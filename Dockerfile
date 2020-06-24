FROM alpine:edge

RUN apk --no-cache upgrade -f

RUN apk --no-cache add php7 php7-fpm php7-opcache php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype php7-session \
    php7-mbstring php7-gd php7-tokenizer php7-pdo_mysql php7-simplexml php7-posix php7-iconv php7-pecl-redis nginx supervisor curl bash && \
    rm /etc/nginx/conf.d/default.conf

COPY config/nginx.conf /etc/nginx/nginx.conf

COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY config/php.ini /etc/php7/conf.d/custom.ini
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /var/www/app/public

RUN chown -R nobody.nobody /var/www/app && \
  chown -R nobody.nobody /run && \
  chown -R nobody.nobody /var/lib/nginx && \
  chown -R nobody.nobody /var/log/nginx

USER nobody

WORKDIR /var/www/app/public
COPY --chown=nobody src/ /var/www/app/public/

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping
