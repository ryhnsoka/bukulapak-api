<?php
// Port data SQLite lokal -> Supabase Postgres (sumber: .env lokal, target: env PG_*).
$src = new PDO('sqlite:'.__DIR__.'/database/database.sqlite');
$src->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$tables = ['users', 'books', 'reviews', 'listings', 'review_likes', 'bookmarks'];

function pgConnect(): PDO
{
    $dsn = sprintf(
        'pgsql:host=%s;port=%s;dbname=%s',
        getenv('PG_HOST'), getenv('PG_PORT'), getenv('PG_DB')
    );
    $pdo = new PDO($dsn, getenv('PG_USER'), getenv('PG_PASS'));
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return $pdo;
}

foreach ($tables as $t) {
    $dst = pgConnect();
    $cols = $src->query('PRAGMA table_info("'.$t.'")')->fetchAll(PDO::FETCH_ASSOC);
    $names = array_column($cols, 'name');
    // Samakan kolom yang ada di kedua sisi (abaikan kolom lokal tak ada di target)
    $dstCols = $dst->query(
        "SELECT column_name FROM information_schema.columns WHERE table_name='$t'"
    )->fetchAll(PDO::FETCH_COLUMN);
    $names = array_values(array_intersect($names, $dstCols));

    // Bersihkan target dulu (urutan aman: anak dulu)
    $dst->exec('TRUNCATE TABLE "'.$t.'" RESTART IDENTITY CASCADE');

    $rows = $src->query('SELECT * FROM "'.$t.'"')->fetchAll(PDO::FETCH_ASSOC);
    $ok = 0;
    $fail = 0;
    foreach ($rows as $row) {
        try {
            $ins = $dst->prepare(
                'INSERT INTO "'.$t.'" ("'.implode('","', $names).'") VALUES ('.implode(',', array_fill(0, count($names), '?')).')'
            );
            $vals = [];
            foreach ($names as $n) {
                $vals[] = $row[$n] ?? null;
            }
            $ins->execute($vals);
            $ok++;
        } catch (Throwable $e) {
            // Reconnect sekali lalu coba lagi baris ini
            try {
                $dst = pgConnect();
                $ins = $dst->prepare(
                    'INSERT INTO "'.$t.'" ("'.implode('","', $names).'") VALUES ('.implode(',', array_fill(0, count($names), '?')).')'
                );
                $vals = [];
                foreach ($names as $n) {
                    $vals[] = $row[$n] ?? null;
                }
                $ins->execute($vals);
                $ok++;
            } catch (Throwable $e2) {
                $fail++;
                echo "  FAIL id=".($row['id'] ?? '?').': '.substr($e2->getMessage(), 0, 120).PHP_EOL;
            }
        }
    }
    echo "$t: $ok ok, $fail fail".PHP_EOL;
    $dst = null;
}
echo "Done".PHP_EOL;
