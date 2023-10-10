# Webman PHP docker image

* add mariadb-client for mysqldump and mysql commands
* add imagemagick for image manipulation
* add parallel for parallel execution of commands
* add tzdata for timezone configuration
* add curl zip unzip nano for convinience
* add intl for internationalization
* add s5cmd for s3 storage support
* run as app user [99:99] so it match user:group of ubuntu:ubuntu host

## run docker

```shell
FROM leekung/webman-imagick:1.0
WORKDIR /app
USER app
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader --prefer-dist
COPY . .
RUN composer install --no-dev --prefer-dist
USER root
RUN chown -R app:app /app
```
