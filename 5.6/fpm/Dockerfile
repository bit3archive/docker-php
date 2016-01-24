FROM php:5.6.17-fpm

# LDAP Workaround: http://serverfault.com/a/444433

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        libbz2-dev \
        libcurl4-openssl-dev \
        libvpx-dev \
        libjpeg-dev \
        libpng12-dev \
        libxpm-dev \
        libfreetype6-dev \
        libicu-dev \
        libldap2-dev \
        libmcrypt-dev \
        libpq-dev \
        libsqlite3-dev \
        libpspell-dev \
        librecode-dev \
        libsnmp-dev\
        libtidy-dev \
        libxml2-dev \
        libxslt-dev \
        libzip-dev \
    && pecl install apcu-4.0.10 && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini \
    && docker-php-ext-install -j$(nproc) bz2 \
    && docker-php-ext-install -j$(nproc) curl \
    && docker-php-ext-install -j$(nproc) ctype \
    && docker-php-ext-install -j$(nproc) dom \
    && docker-php-ext-install -j$(nproc) exif \
    && docker-php-ext-install -j$(nproc) fileinfo \
    && docker-php-ext-install -j$(nproc) ftp \
    && docker-php-ext-configure gd --with-vpx-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ --with-xpm-dir=/usr/include/ -with-freetype-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) gettext \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) json \
    && ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/ \
    && docker-php-ext-install -j$(nproc) ldap \
    && docker-php-ext-install -j$(nproc) mbstring \
    && docker-php-ext-install -j$(nproc) mcrypt \
    && docker-php-ext-install -j$(nproc) mysql \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) pcntl \
    && docker-php-ext-install -j$(nproc) pdo \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && docker-php-ext-install -j$(nproc) pdo_sqlite \
    && docker-php-ext-install -j$(nproc) pgsql \
    && docker-php-ext-install -j$(nproc) phar \
    && docker-php-ext-install -j$(nproc) posix \
    && docker-php-ext-install -j$(nproc) pspell \
    && docker-php-ext-install -j$(nproc) recode \
    && docker-php-ext-install -j$(nproc) session \
    && docker-php-ext-install -j$(nproc) snmp \
    && docker-php-ext-install -j$(nproc) soap \
    && docker-php-ext-install -j$(nproc) sockets \
    && docker-php-ext-install -j$(nproc) tidy \
    && docker-php-ext-install -j$(nproc) tokenizer \
    && docker-php-ext-install -j$(nproc) xml \
    && docker-php-ext-install -j$(nproc) xmlreader \
    && docker-php-ext-install -j$(nproc) xmlrpc \
    && docker-php-ext-install -j$(nproc) xmlwriter \
    && docker-php-ext-install -j$(nproc) xsl \
    && docker-php-ext-install -j$(nproc) zip \
    && echo "; General settings" > /usr/local/etc/php/conf.d/general.ini \
    && echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "upload_max_filesize = 1G" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "post_max_size = 1G" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "; Date" > /usr/local/etc/php/conf.d/date.ini \
    && echo "date.timezone = Europe/Berlin" >> /usr/local/etc/php/conf.d/date.ini \
    && echo "; Symfony2 requirements / recommendations" > /usr/local/etc/php/conf.d/sf2.ini \
    && echo "short_open_tag = Off" >> /usr/local/etc/php/conf.d/sf2.ini \
    && echo "magic_quotes_gpc = Off" >> /usr/local/etc/php/conf.d/sf2.ini \
    && echo "register_globals = Off" >> /usr/local/etc/php/conf.d/sf2.ini \
    && echo "session.auto_start = Off" >> /usr/local/etc/php/conf.d/sf2.ini \
    && rm -r /var/lib/apt/lists/*
