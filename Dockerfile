FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
        libmhash2 \
        libmcrypt-dev \
        bzip2 \
        libbz2-dev \
        libicu-dev \
        libgmp-dev \
        libpcre3-dev \
        libjpeg-dev \
        libpng12-dev \
        libreadline6-dev \
        librecode-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libcurl4-gnutls-dev \
        libxslt1-dev \
        libldb-dev \
        libldap2-dev \
        libtidy-dev \
        libpq-dev \
        git \
        nodejs \
        npm \
     && ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
     && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so \
     && ln -s /usr/bin/nodejs /usr/bin/node \
     && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
     && docker-php-ext-install -j$(nproc) bz2 bcmath intl soap gd zip pdo_mysql pdo_pgsql ldap mcrypt tidy \
     && docker-php-ext-enable opcache \
     && pecl install xdebug && docker-php-ext-enable xdebug \
     && npm install --global bower

COPY php.ini /usr/local/etc/php
COPY xdebug.ini /usr/local/etc/php/conf.d/

# Setup the Composer installer
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
 && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
 && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
 && php /tmp/composer-setup.php --no-ansi --version=1.2.2 --install-dir=/usr/local/bin --filename=composer --snapshot \
 && rm -rf /tmp/composer-setup.php \
 && mkdir /var/www/.composer \
 && chown www-data:www-data /var/www/.composer 

USER www-data
RUN /usr/local/bin/composer global require "fxp/composer-asset-plugin:~1.2"
USER root

RUN usermod -u 1000 www-data

