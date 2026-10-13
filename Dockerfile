FROM php:8.3-apache

# Ekstensi yang dibutuhkan Laravel + Postgres
RUN apt-get update && apt-get install -y \
    libpq-dev libzip-dev unzip git \
    && docker-php-ext-install pdo pdo_pgsql pgsql zip bcmath \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Apache menunjuk ke public/
RUN a2enmod rewrite \
    && a2dissite 000-default \
    && printf '<VirtualHost *:80>\n    DocumentRoot /var/www/html/public\n    <Directory /var/www/html/public>\n        Options Indexes FollowSymLinks\n        AllowOverride All\n        Require all granted\n    </Directory>\n</VirtualHost>\n' > /etc/apache2/sites-available/bukulapak.conf \
    && a2ensite bukulapak

WORKDIR /var/www/html
COPY . .

RUN composer install --no-dev --optimize-autoloader --no-interaction \
    && mkdir -p storage/framework/{sessions,views,cache} storage/logs public/uploads \
    && chown -R www-data:www-data storage bootstrap/cache public/uploads

EXPOSE 80 10000

# Migrasi otomatis tiap deploy, lalu jalankan server Laravel di port Render ($PORT)
CMD sh -c "php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=${PORT:-10000}"
