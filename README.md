# Docker Containers

## bit3/composer

A docker container that contains [composer](https://getcomposer.org/).
To use this image, I prefer to set an alias like this one:

```
alias composer='docker run --rm -it --user=$UID --volume=$HOME/.composer:/.composer --volume=$(pwd):/var/www/html bit3/composer composer'
```

## bit3/php-all

PHP containers containing a lot php modules! Useful for developmers, not designed for production usage!

### List of modules

- apcu
- bz2
- curl
- ctype
- dom
- exif
- fileinfo
- ftp
- gd
- gettext
- iconv
- intl
- json
- ldap
- mbstring
- mcrypt
- mysql (php 5.x only)
- mysqli
- pcntl
- pdo
- pdo_mysql
- pdo_pgsql
- pdo_sqlite
- pgsql
- phar
- posix
- pspell
- recode
- session
- snmp
- soap
- sockets
- tidy
- tokenizer
- xdebug (`*-debug` versions only)
- xml
- xmlreader (php 5.x only)
- xmlrpc
- xmlwriter (php 5.x only)
- xsl
- zip

### Configuration tweaks

#### php-all

```ini
; Development
error_reporting = E_ALL

; Date
date.timezone = Europe/Berlin

; Symfony2 requirements / recommendations
short_open_tag = Off
magic_quotes_gpc = Off
register_globals = Off
session.auto_start = Off
```

#### php-all-debug

```ini
; Debugging settings
; xdebug.remote_autostart = 1
xdebug.remote_enable = 1
xdebug.remote_host = 172.17.0.1
; xdebug.remote_port = 9000
```
