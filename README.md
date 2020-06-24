# alpine-nginx-php
Container based on Alpine with nginx and php-fpm and all required libs to use with Symfony 5

## Extending image

### Installing composer
```
FROM mephir/alpine-nginx-php:latest

# Install composer
RUN curl -sS -f https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
```

### Installing symfony cli
```
FROM mephir/alpine-nginx-php:latest

# Installation of symfony cli
RUN curl -s https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony/bin/symfony /usr/local/bin/symfony && \
    rm -rf /root/.symfony
```
