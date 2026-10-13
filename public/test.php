<?php
header('Content-Type: text/plain');
echo 'DIR: '.__DIR__."\n";
echo 'PARENT: '.realpath(__DIR__.'/..')."\n";
echo '--- isi parent ---'."\n";
foreach (@scandir(__DIR__.'/..') ?: ['GAGAL SCAN'] as $f) echo $f."\n";
echo '--- cek bukulapak ---'."\n";
echo 'is_dir ../bukulapak: '.(is_dir(__DIR__.'/../bukulapak') ? 'YA' : 'TIDAK')."\n";
