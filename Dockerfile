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
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

WORKDIR /var/www/html
COPY . .

RUN composer install --no-dev --optimize-autoloader --no-interaction \
    && mkdir -p storage/framework/{sessions,views,cache} storage/logs public/uploads \
    && chown -R www-data:www-data storage bootstrap/cache public/uploads

EXPOSE 80

# Migrasi otomatis tiap deploy, lalu jalankan Apache
CMD php artisan migrate --force && apache2-foreground
