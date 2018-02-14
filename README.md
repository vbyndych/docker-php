# docker-php [![](https://images.microbadger.com/badges/image/vbyndych/oro-docker-php.svg)](https://microbadger.com/images/vbyndych/oro-docker-php "Get your own image badge on microbadger.com")
PHP image for ORO

## docker-compose.yml config example:

```
php:
    image: vbyndych/oro-docker-php:latest
    mem_limit: 512m
    links:
        - db
    volumes:
        - ~/.composer/cache:/var/www/.composer/cache
        - ./:/var/www/html/
    working_dir: /var/www/html
```

## useful commands

`php -d memory_limit=9G /usr/local/bin/composer update -vv`

`php -d memory_limit=9G /usr/local/bin/composer update oro/redis-config -vv --with-dependencies --no-plugins --no-scripts`