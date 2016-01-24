FROM php:7.0-cli

# Install system packages
RUN set -x \
    && apt-get update \
    && apt-get install -y git \
    && rm -r /var/lib/apt/lists/*

# install zip php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libzip2 libzip-dev \
    && docker-php-ext-install -j$(nproc) zip \
    && apt-get remove -y libzip-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# set general settings
RUN echo "; General settings" > /usr/local/etc/php/conf.d/general.ini \
    && echo "short_open_tag = Off" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "magic_quotes_gpc = Off" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "register_globals = Off" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "session.auto_start = Off" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "date.timezone = Europe/Berlin" >> /usr/local/etc/php/conf.d/general.ini

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# set the working dir
WORKDIR /var/www/html

# set the command
CMD ["composer"]
