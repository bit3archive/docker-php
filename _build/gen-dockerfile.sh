#!/usr/bin/env bash

set -eo pipefail

die() {
    >&2 echo -e "\033[91m * \033[0m$1";
    exit 128;
}

isPHP5() {
    MAJOR=$(echo "$VERSION" | awk -F '.' '{print $1}')
    [[ "$MAJOR" -lt 7 ]] && echo 1 || echo ""
}

isPHP7() {
    MAJOR=$(echo "$VERSION" | awk -F '.' '{print $1}')
    [[ "$MAJOR" -ge 7 ]] && echo 1 || echo ""
}

# Read script options
while getopts hv:k: OPT; do
    case $OPT in
        "h") cat <<HELP
Synopsis: gen-dockerfile.sh -v <version> [-k <kind>] <options>

Options:
  -v <version>  Set the php version (e.g. "5.6")
  -k <kind>     Set the kind of the image (e.g. "fpm")
HELP
            exit
            ;;
        "v")
            VERSION=$OPTARG
            ;;
        "k")
            KIND=$OPTARG
            ;;
    esac
done

if [[ -z "$VERSION" ]]; then
    die "Parameter -v <version> is mandatory"
fi

if [[ -n "$KIND" ]]; then
    FROM_VERSION="$VERSION-$KIND"
else
    FROM_VERSION="$VERSION"
fi

>&2 echo -e "\033[33m * \033[0mVersion: \033[96m$VERSION\033[0m"
>&2 echo -e "\033[33m * \033[0mKind: \033[96m$KIND\033[0m"

APCU4=`isPHP5`
APCU5=`isPHP7`
BZ2=1
CURL=1
CTYPE=1
DOM=1
EXIF=1
FILEINFO=1
FTP=1
GD=1
GETTEXT=1
ICONV=1
INTL=1
JSON=1
LDAP=1
MBSTRING=1
MCRYPT=1
MYSQL=`isPHP5`
MYSQLI=1
PCNTL=1
PDO=1
PGSQL=1
PHAR=1
POSIX=1
PSPELL=1
RECODE=1
SESSION=1
SNMP=1
SOAP=1
SOCKETS=1
TIDY=1
TOKENIZER=1
XML=1
XMLREADER=`isPHP5`
XMLRPC=1
XMLWRITER=`isPHP5`
XSL=1
ZIP=1

cat <<EOF
FROM php:${FROM_VERSION}

# Make sure conf.d exists
RUN set -x \\
    && mkdir -p /usr/local/etc/php/conf.d/

# Install system packages
RUN set -x \\
    && apt-get update \\
    && apt-get install -y vim git zsh \\
    && rm -r /var/lib/apt/lists/*

EOF

if [[ -n "$APCU4" ]]; then
    cat <<EOF
# install apcu php module
RUN set -x \\
    && pecl install apcu-4.0.11 \\
    && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

EOF
fi

if [[ -n "$APCU5" ]]; then
    cat <<EOF
# install apcu php module
RUN set -x \\
    && pecl install apcu-5.1.5 \\
    && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

EOF
fi

if [[ -n "$BZ2" ]]; then
    cat <<EOF
# install bz2 php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y bzip2 libbz2-dev \\
    && docker-php-ext-install bz2 \\
    && apt-get remove -y libbz2-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$CURL" ]]; then
    cat <<EOF
# install curl php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libcurl4-openssl-dev libssl1.0.0 libssl-dev \\
    && docker-php-ext-install curl \\
    && apt-get remove -y libcurl4-openssl-dev libssl-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$CTYPE" ]]; then
    cat <<EOF
# install ctype php module
RUN docker-php-ext-install ctype

EOF
fi

if [[ -n "$DOM" ]]; then
    cat <<EOF
# install dom php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libxml2 libxml2-dev \\
    && docker-php-ext-install dom \\
    && apt-get remove -y libxml2-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$EXIF" ]]; then
    cat <<EOF
# install exif php module
RUN docker-php-ext-install exif

EOF
fi

if [[ -n "$FILEINFO" ]]; then
    cat <<EOF
# install fileinfo php module
RUN docker-php-ext-install fileinfo

EOF
fi

if [[ -n "$FTP" ]]; then
    cat <<EOF
# install ftp php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libssl1.0.0 libssl-dev \\
    && docker-php-ext-install ftp \\
    && apt-get remove -y libssl-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$GD" ]]; then
    cat <<EOF
# install gd php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libvpx1 libvpx-dev libjpeg62-turbo libjpeg62-turbo-dev libpng12-0 libpng12-dev libxpm4 libxpm-dev libfreetype6 libfreetype6-dev \\
    && docker-php-ext-configure gd --with-vpx-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ --with-xpm-dir=/usr/include/ -with-freetype-dir=/usr/include/ \\
    && docker-php-ext-install gd \\
    && apt-get remove -y libvpx-dev libjpeg-dev libpng12-dev libxpm-dev libfreetype6-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$GETTEXT" ]]; then
    cat <<EOF
# install gettext php module
RUN docker-php-ext-install gettext

EOF
fi

if [[ -n "$ICONV" ]]; then
    cat <<EOF
# install iconv php module
RUN docker-php-ext-install iconv

EOF
fi

if [[ -n "$INTL" ]]; then
    cat <<EOF
# install intl php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y g++ libicu52 libicu-dev \\
    && docker-php-ext-install intl \\
    && apt-get remove -y g++ libicu-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$JSON" ]]; then
    cat <<EOF
# install json php module
RUN docker-php-ext-install json

EOF
fi

if [[ -n "$LDAP" ]]; then
    cat <<EOF
# install ldap php module
# Workaround: http://serverfault.com/a/444433
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libldap-2.4-2 libldap2-dev \\
    && ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/ \\
    && docker-php-ext-install ldap \\
    && apt-get remove -y libldap2-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$MBSTRING" ]]; then
    cat <<EOF
# install mbstring php module
RUN docker-php-ext-install mbstring

EOF
fi

if [[ -n "$MCRYPT" ]]; then
    cat <<EOF
# install mcrypt php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libmcrypt4 libmcrypt-dev \\
    && docker-php-ext-install mcrypt \\
    && apt-get remove -y libmcrypt-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$MYSQL" ]]; then
    cat <<EOF
# install mysql php module
RUN docker-php-ext-install mysql

EOF
fi

if [[ -n "$MYSQLI" ]]; then
    cat <<EOF
# install mysqli php module
RUN docker-php-ext-install mysqli

EOF
fi

if [[ -n "$PCNTL" ]]; then
    cat <<EOF
# install pcntl php module
RUN docker-php-ext-install pcntl

EOF
fi

if [[ -n "$PDO" ]]; then
    cat <<EOF
# install pdo php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libpq5 libpq-dev libsqlite3-0 libsqlite3-dev \\
    && docker-php-ext-install pdo \\
    && docker-php-ext-install pdo_mysql \\
    && docker-php-ext-install pdo_pgsql \\
    && docker-php-ext-install pdo_sqlite \\
    && apt-get remove -y libpq-dev libsqlite3-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$PGSQL" ]]; then
    cat <<EOF
# install pgsql php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libpq5 libpq-dev \\
    && docker-php-ext-install pgsql \\
    && apt-get remove -y libpq-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$PHAR" ]]; then
    cat <<EOF
# install phar php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libssl1.0.0 libssl-dev \\
    && docker-php-ext-install phar \\
    && apt-get remove -y libssl-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$POSIX" ]]; then
    cat <<EOF
# install posix php module
RUN docker-php-ext-install posix

EOF
fi

if [[ -n "$PSPELL" ]]; then
    cat <<EOF
# install pspell php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libaspell15 libpspell-dev \\
    && docker-php-ext-install pspell \\
    && apt-get remove -y libpspell-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$RECODE" ]]; then
    cat <<EOF
# install recode php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y librecode0 librecode-dev \\
    && docker-php-ext-install recode \\
    && apt-get remove -y librecode-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$SESSION" ]]; then
    cat <<EOF
# install session php module
RUN docker-php-ext-install session

EOF
fi

if [[ -n "$SNMP" ]]; then
    cat <<EOF
# install snmp php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y snmp libsnmp30 libsnmp-dev \\
    && docker-php-ext-install snmp \\
    && apt-get remove -y libsnmp-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$SOAP" ]]; then
    cat <<EOF
# install soap php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libxml2 libxml2-dev \\
    && docker-php-ext-install soap \\
    && apt-get remove -y libxml2-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$SOCKETS" ]]; then
    cat <<EOF
# install sockets php module
RUN docker-php-ext-install sockets

EOF
fi

if [[ -n "$TIDY" ]]; then
    cat <<EOF
# install tidy php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libtidy-0.99-0 libtidy-dev \\
    && docker-php-ext-install tidy \\
    && apt-get remove -y libtidy-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$TOKENIZER" ]]; then
    cat <<EOF
# install tokenizer php module
RUN docker-php-ext-install tokenizer

EOF
fi

if [[ -n "$XML" ]]; then
    cat <<EOF
# install xml php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libxml2 libxml2-dev \\
    && docker-php-ext-install xml \\
    && apt-get remove -y libxml2-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$XMLREADER" ]]; then
    cat <<EOF
# install xmlreader php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libxml2 libxml2-dev \\
    && docker-php-ext-install xmlreader \\
    && apt-get remove -y libxml2-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$XMLRPC" ]]; then
    cat <<EOF
# install xmlrpc php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libxml2 libxml2-dev \\
    && docker-php-ext-install xmlrpc \\
    && apt-get remove -y libxml2-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$XMLWRITER" ]]; then
    cat <<EOF
# install xmlwriter php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libxml2 libxml2-dev \\
    && docker-php-ext-install xmlwriter \\
    && apt-get remove -y libxml2-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$XSL" ]]; then
    cat <<EOF
# install xsl php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libxslt1.1 libxslt-dev \\
    && docker-php-ext-install xsl \\
    && apt-get remove -y libxslt-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

if [[ -n "$ZIP" ]]; then
    cat <<EOF
# install zip php module
RUN set -x \\
    && apt-get update \\
    && apt-get install -y libzip2 libzip-dev \\
    && docker-php-ext-install zip \\
    && apt-get remove -y libzip-dev \\
    && apt-get autoremove -y \\
    && rm -r /var/lib/apt/lists/*

EOF
fi

cat <<EOF
# set general settings
RUN echo "; General settings" > /usr/local/etc/php/conf.d/general.ini \\
    && echo "short_open_tag = Off" >> /usr/local/etc/php/conf.d/general.ini \\
    && echo "magic_quotes_gpc = Off" >> /usr/local/etc/php/conf.d/general.ini \\
    && echo "register_globals = Off" >> /usr/local/etc/php/conf.d/general.ini \\
    && echo "session.auto_start = Off" >> /usr/local/etc/php/conf.d/general.ini \\
    && echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/general.ini \\
    && echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/general.ini \\
    && echo "upload_max_filesize = 1G" >> /usr/local/etc/php/conf.d/general.ini \\
    && echo "post_max_size = 1G" >> /usr/local/etc/php/conf.d/general.ini \\
    && echo "date.timezone = Europe/Berlin" >> /usr/local/etc/php/conf.d/general.ini

# zsh git prompt
RUN set -x \\
    && git clone https://github.com/olivierverdier/zsh-git-prompt.git /opt/zsh-git-prompt \\
    && rm -rf /opt/zsh-git-prompt/.git

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# setup zsh
COPY zshrc /etc/zsh/zshrc
RUN set -x \\
    && git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git /opt/oh-my-zsh \\
    && rm -rf /opt/oh-my-zsh/.git

# set the working dir
WORKDIR /var/www/html

# set the command
CMD ["zsh"]
EOF
