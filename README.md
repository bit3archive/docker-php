# PHP Docker Container for developers

Contains a lot of php5 modules!
Useful for local development fpm servers.

## List of modules

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
- mysql
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
- xml
- xmlreader
- xmlrpc
- xmlwriter
- xsl
- zip

## Configuration tweaks

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
