ARG PHP_CLI_VERSION=8.1-cli-alpine
FROM krisss/docker-webman:$PHP_CLI_VERSION
ARG APP_PORT=8887
ENV APP_PORT=$APP_PORT
ARG TZ=Asia/Bangkok
ENV TZ=$TZ

RUN apk add --no-cache curl zip unzip nano tzdata mariadb-client parallel imagemagick
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone
# https://github.com/mlocati/docker-php-extension-installer#supported-php-extensions
RUN install-php-extensions intl

# s5cmd
RUN curl -L -o s5cmd.tar.gz https://github.com/peak/s5cmd/releases/download/v2.2.2/s5cmd_2.2.2_Linux-64bit.tar.gz
RUN tar -xf s5cmd.tar.gz && mv s5cmd /usr/local/bin/ && rm s5cmd.tar.gz

# php customizations
COPY app.ini "$PHP_INI_DIR/conf.d/app.ini"

# run as user app [99:99]
RUN mkdir -p /app
WORKDIR /app
RUN addgroup -g 99 -S app && adduser -u 99 -D -S -G app -h /app -s /bin/sh app

EXPOSE $APP_PORT
CMD ["/app/webman", "start"]
