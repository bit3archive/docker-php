FROM bit3/php-all:5.6.17-cli

# install xdebug php module
RUN set -x \
    && pecl install xdebug-2.3.3 \
    && echo zend_extension=xdebug.so > /usr/local/etc/php/conf.d/xdebug.ini

# set debugging settings
RUN echo "; Debugging settings" > /usr/local/etc/php/conf.d/debug.ini \
    && echo "display_startup_errors = 1" >> /usr/local/etc/php/conf.d/debug.ini \
    && echo "display_errors = 1" >> /usr/local/etc/php/conf.d/debug.ini \
    && echo "; xdebug.remote_autostart = 1" >> /usr/local/etc/php/conf.d/debug.ini \
    && echo "xdebug.remote_enable = 1" >> /usr/local/etc/php/conf.d/debug.ini \
    && echo "xdebug.remote_host = 172.17.0.1" >> /usr/local/etc/php/conf.d/debug.ini \
    && echo "; xdebug.remote_port = 9000" >> /usr/local/etc/php/conf.d/debug.ini \
    && echo ";xdebug.profiler_output_dir = /var/www/html" >> /usr/local/etc/php/conf.d/debug.ini
