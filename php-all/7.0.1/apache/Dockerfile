FROM php:7.0.1-apache

# Make sure conf.d exists
RUN set -x \
    && mkdir -p /usr/local/etc/php/conf.d/

# Install system packages
RUN set -x \
    && apt-get update \
    && apt-get install -y vim git zsh \
    && rm -r /var/lib/apt/lists/*

# install apcu php module
RUN set -x \
    && pecl install apcu-5.1.5 \
    && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

# install bz2 php module
RUN set -x \
    && apt-get update \
    && apt-get install -y bzip2 libbz2-dev \
    && docker-php-ext-install bz2 \
    && apt-get remove -y libbz2-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install curl php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libcurl4-openssl-dev libssl1.0.0 libssl-dev \
    && docker-php-ext-install curl \
    && apt-get remove -y libcurl4-openssl-dev libssl-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install ctype php module
RUN docker-php-ext-install ctype

# install dom php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libxml2 libxml2-dev \
    && docker-php-ext-install dom \
    && apt-get remove -y libxml2-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install exif php module
RUN docker-php-ext-install exif

# install fileinfo php module
RUN docker-php-ext-install fileinfo

# install ftp php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libssl1.0.0 libssl-dev \
    && docker-php-ext-install ftp \
    && apt-get remove -y libssl-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install gd php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libvpx1 libvpx-dev libjpeg62-turbo libjpeg62-turbo-dev libpng12-0 libpng12-dev libxpm4 libxpm-dev libfreetype6 libfreetype6-dev \
    && docker-php-ext-configure gd --with-vpx-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ --with-xpm-dir=/usr/include/ -with-freetype-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && apt-get remove -y libvpx-dev libjpeg-dev libpng12-dev libxpm-dev libfreetype6-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install gettext php module
RUN docker-php-ext-install gettext

# install iconv php module
RUN docker-php-ext-install iconv

# install intl php module
RUN set -x \
    && apt-get update \
    && apt-get install -y g++ libicu52 libicu-dev \
    && docker-php-ext-install intl \
    && apt-get remove -y g++ libicu-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install json php module
RUN docker-php-ext-install json

# install ldap php module
# Workaround: http://serverfault.com/a/444433
RUN set -x \
    && apt-get update \
    && apt-get install -y libldap-2.4-2 libldap2-dev \
    && ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/ \
    && docker-php-ext-install ldap \
    && apt-get remove -y libldap2-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install mbstring php module
RUN docker-php-ext-install mbstring

# install mcrypt php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libmcrypt4 libmcrypt-dev \
    && docker-php-ext-install mcrypt \
    && apt-get remove -y libmcrypt-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install mysqli php module
RUN docker-php-ext-install mysqli

# install pcntl php module
RUN docker-php-ext-install pcntl

# install pdo php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libpq5 libpq-dev libsqlite3-0 libsqlite3-dev \
    && docker-php-ext-install pdo \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install pdo_sqlite \
    && apt-get remove -y libpq-dev libsqlite3-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install pgsql php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libpq5 libpq-dev \
    && docker-php-ext-install pgsql \
    && apt-get remove -y libpq-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install phar php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libssl1.0.0 libssl-dev \
    && docker-php-ext-install phar \
    && apt-get remove -y libssl-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install posix php module
RUN docker-php-ext-install posix

# install pspell php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libaspell15 libpspell-dev \
    && docker-php-ext-install pspell \
    && apt-get remove -y libpspell-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install recode php module
RUN set -x \
    && apt-get update \
    && apt-get install -y librecode0 librecode-dev \
    && docker-php-ext-install recode \
    && apt-get remove -y librecode-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install session php module
RUN docker-php-ext-install session

# install snmp php module
RUN set -x \
    && apt-get update \
    && apt-get install -y snmp libsnmp30 libsnmp-dev \
    && docker-php-ext-install snmp \
    && apt-get remove -y libsnmp-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install soap php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libxml2 libxml2-dev \
    && docker-php-ext-install soap \
    && apt-get remove -y libxml2-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install sockets php module
RUN docker-php-ext-install sockets

# install tidy php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libtidy-0.99-0 libtidy-dev \
    && docker-php-ext-install tidy \
    && apt-get remove -y libtidy-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install tokenizer php module
RUN docker-php-ext-install tokenizer

# install xml php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libxml2 libxml2-dev \
    && docker-php-ext-install xml \
    && apt-get remove -y libxml2-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install xmlrpc php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libxml2 libxml2-dev \
    && docker-php-ext-install xmlrpc \
    && apt-get remove -y libxml2-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install xsl php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libxslt1.1 libxslt-dev \
    && docker-php-ext-install xsl \
    && apt-get remove -y libxslt-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# install zip php module
RUN set -x \
    && apt-get update \
    && apt-get install -y libzip2 libzip-dev \
    && docker-php-ext-install zip \
    && apt-get remove -y libzip-dev \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# set general settings
RUN echo "; General settings" > /usr/local/etc/php/conf.d/general.ini \
    && echo "short_open_tag = Off" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "magic_quotes_gpc = Off" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "register_globals = Off" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "session.auto_start = Off" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "upload_max_filesize = 1G" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "post_max_size = 1G" >> /usr/local/etc/php/conf.d/general.ini \
    && echo "date.timezone = Europe/Berlin" >> /usr/local/etc/php/conf.d/general.ini

# zsh git prompt
RUN set -x \
    && git clone https://github.com/olivierverdier/zsh-git-prompt.git /opt/zsh-git-prompt \
    && rm -rf /opt/zsh-git-prompt/.git

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# setup zsh
COPY zshrc /etc/zsh/zshrc
RUN set -x \
    && git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git /opt/oh-my-zsh \
    && rm -rf /opt/oh-my-zsh/.git

# set the working dir
WORKDIR /var/www/html

# set the command
CMD ["zsh"]
