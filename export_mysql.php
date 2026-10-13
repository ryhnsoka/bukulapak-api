<?php
// Konversi database SQLite lokal -> file SQL MySQL untuk import via phpMyAdmin.
// Jalankan: php export_mysql.php > bukulapak.sql

$db = new PDO('sqlite:'.__DIR__.'/database/database.sqlite');
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$out = [];
$out[] = 'SET FOREIGN_KEY_CHECKS=0;';
$out[] = 'SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";';
$out[] = '';

$order = ['users', 'password_reset_tokens', 'sessions', 'cache', 'cache_locks', 'jobs', 'job_batches', 'failed_jobs', 'personal_access_tokens', 'books', 'reviews', 'listings', 'review_likes', 'bookmarks', 'conversations', 'messages', 'orders', 'migrations'];

$tables = $db->query("SELECT name, sql FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")->fetchAll(PDO::FETCH_ASSOC);
$byName = [];
foreach ($tables as $t) $byName[$t['name']] = $t['sql'];

$ordered = [];
foreach ($order as $n) if (isset($byName[$n])) $ordered[$n] = $byName[$n];
foreach ($byName as $n => $sql) if (!isset($ordered[$n])) $ordered[$n] = $sql;

function stripCheck(string $def): string
{
    // Hapus klausa CHECK (...) SQLite (dukungan MySQL tak konsisten + pakai double-quote)
    $out = '';
    $len = strlen($def);
    for ($i = 0; $i < $len; $i++) {
        if (preg_match('/\Gcheck\s*\(/i', $def, $m, 0, $i)) {
            $i = strpos($def, '(', $i);
            $depth = 0;
            do {
                if ($def[$i] === '(') $depth++;
                if ($def[$i] === ')') $depth--;
                $i++;
            } while ($depth > 0 && $i < $len);
            $i--;
            continue;
        }
        $out .= $def[$i];
    }
    return trim(preg_replace('/\s+/', ' ', $out));
}

function convertDDL(string $name, string $sql): string
{
    // Ambil isi dalam kurung terluar
    $start = strpos($sql, '(');
    $body = substr($sql, $start + 1, strrpos($sql, ')') - $start - 1);

    // Pecah per koma level atas
    $parts = [];
    $depth = 0;
    $cur = '';
    $inStr = false;
    $len = strlen($body);
    for ($i = 0; $i < $len; $i++) {
        $c = $body[$i];
        if ($c === "'" && ($i === 0 || $body[$i - 1] !== '\\')) $inStr = ! $inStr;
        if (! $inStr) {
            if ($c === '(') $depth++;
            if ($c === ')') $depth--;
            if ($c === ',' && $depth === 0) {
                $parts[] = trim($cur);
                $cur = '';
                continue;
            }
        }
        $cur .= $c;
    }
    if (trim($cur) !== '') $parts[] = trim($cur);

    $cols = [];
    $keys = [];
    foreach ($parts as $p) {
        // Foreign key SQLite -> KEY + CONSTRAINT
        if (preg_match('/^FOREIGN KEY\s*\("?(\w+)"?\)\s*REFERENCES\s*"?(\w+)"?\s*\("?(\w+)"?\)(.*)$/i', $p, $m)) {
            $keys[] = "  KEY `{$m[1]}` (`{$m[1]}`)";
            $keys[] = "  CONSTRAINT `{$name}_{$m[1]}_foreign` FOREIGN KEY (`{$m[1]}`) REFERENCES `{$m[2]}` (`{$m[3]}`)".trim($m[4]);
            continue;
        }
        if (preg_match('/^(PRIMARY KEY|UNIQUE|CHECK|CONSTRAINT)\b/i', $p)) {
            if (preg_match('/^PRIMARY KEY\s*\((.+)\)$/i', $p, $m)) {
                $colsList = implode(',', array_map(fn ($c) => '`'.trim($c, ' "').'`', explode(',', $m[1])));
                $keys[] = "  PRIMARY KEY ($colsList)";
                continue;
            }
            if (preg_match('/^UNIQUE\s*\((.+)\)$/i', $p, $m)) {
                $colsList = implode(',', array_map(fn ($c) => '`'.trim($c, ' "').'`', explode(',', $m[1])));
                $keys[] = "  UNIQUE KEY `{$name}_uniq_" . md5($colsList) . "` ($colsList)";
                continue;
            }
            if (preg_match('/^CONSTRAINT\s+"?(\w+)"?\s+(.*)$/is', $p, $m)) {
                $keys[] = '  CONSTRAINT `'.$m[1].'` '.$m[2];
                continue;
            }
            continue; // skip CHECK
        }
        if (! preg_match('/^"(\w+)"\s+(.*)$/s', $p, $m)) continue;
        [$full, $col, $def] = $m;
        $def = preg_replace('/\bAUTOINCREMENT\b/i', 'AUTO_INCREMENT', $def);
        $def = preg_replace('/\binteger\b/i', 'INT', $def);
        $def = preg_replace('/\bVARCHAR\b(?!\s*\()/i', 'VARCHAR(255)', $def);
        $def = preg_replace('/\bNUMERIC\b(?!\s*\()/i', 'DECIMAL(10,2)', $def);
        $def = preg_replace_callback('/\b(float|double|decimal)(\([^)]*\))?/i', fn ($mm) => strtoupper($mm[1]).($mm[2] ?? ''), $def);
        $def = stripCheck($def);
        $cols[] = "  `$col` $def";
    }

    $all = array_merge($cols, $keys);
    return "DROP TABLE IF EXISTS `$name`;\nCREATE TABLE `$name` (\n".implode(",\n", $all)."\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;";
}

foreach ($ordered as $name => $sql) {
    $out[] = convertDDL($name, $sql);
    $out[] = '';

    $cols = $db->query('PRAGMA table_info("'.$name.'")')->fetchAll(PDO::FETCH_ASSOC);
    $colNames = array_column($cols, 'name');
    $rows = $db->query('SELECT * FROM "'.$name.'"')->fetchAll(PDO::FETCH_NUM);
    if (! $rows) continue;

    $chunks = array_chunk($rows, 100);
    foreach ($chunks as $chunk) {
        $vals = [];
        foreach ($chunk as $row) {
            $v = [];
            foreach ($row as $val) {
                if ($val === null) {
                    $v[] = 'NULL';
                } elseif (is_int($val) || is_float($val)) {
                    $v[] = (string) $val;
                } else {
                    $v[] = "'".str_replace(['\\', "'"], ['\\\\', "\\'"], $val)."'";
                }
            }
            $vals[] = '('.implode(',', $v).')';
        }
        $out[] = 'INSERT INTO `'.$name.'` (`'.implode('`,`', $colNames)."`) VALUES\n".implode(",\n", $vals).';';
    }
    $out[] = '';
}

$out[] = 'SET FOREIGN_KEY_CHECKS=1;';

$indexes = $db->query("SELECT tbl_name, sql FROM sqlite_master WHERE type='index' AND sql IS NOT NULL")->fetchAll(PDO::FETCH_ASSOC);
foreach ($indexes as $idx) {
    if (preg_match('/CREATE UNIQUE INDEX "([^"]+)" ON "([^"]+)" \((.+)\)/i', $idx['sql'], $m)) {
        $cols = implode(',', array_map(fn ($c) => '`'.trim(trim($c), '"').'`', explode(',', $m[3])));
        $out[] = "ALTER TABLE `{$m[2]}` ADD UNIQUE KEY `{$m[1]}` ($cols);";
    }
}

file_put_contents(__DIR__.'/bukulapak.sql', implode("\n", $out));
echo 'Wrote bukulapak.sql ('.filesize(__DIR__.'/bukulapak.sql').' bytes)'.PHP_EOL;
