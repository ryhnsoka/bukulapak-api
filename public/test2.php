<?php
header('Content-Type: text/plain');
$base = __DIR__.'/laravel';
try {
    require $base.'/vendor/autoload.php';
    echo "1. autoload OK\n";
    $app = require_once $base.'/bootstrap/app.php';
    echo "2. bootstrap OK\n";
    $kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);
    echo "3. kernel OK\n";
    $request = Illuminate\Http\Request::create('/api/health', 'GET');
    $response = $kernel->handle($request);
    echo '4. STATUS: '.$response->getStatusCode()."\n";
    echo substr($response->getContent(), 0, 500)."\n";
} catch (Throwable $e) {
    echo 'ERROR: '.get_class($e)."\n";
    echo 'MSG: '.$e->getMessage()."\n";
    echo 'FILE: '.$e->getFile().' LINE: '.$e->getLine()."\n";
}
