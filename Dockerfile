# مرحلة البناء (لو احتجنا تثبيت تبعيات Composer)
FROM php:8.2-cli AS build
WORKDIR /app
COPY composer.json composer.lock* ./
RUN php -r "copy('https://getcomposer.org/installer','composer-setup.php');" \
 && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
 && rm composer-setup.php
RUN composer install --no-dev --no-interaction --no-ansi --no-progress || true

# مرحلة التشغيل: Apache يقدم موقع PHP
FROM php:8.2-apache
WORKDIR /var/www/html
# إعداد DocumentRoot إلى public
RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf \
    && a2enmod rewrite
COPY . /var/www/html
# لو لم تستخدم Composer، احذف السطر التالي
COPY --from=build /app/vendor /var/www/html/vendor
EXPOSE 80
