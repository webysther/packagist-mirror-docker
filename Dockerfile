FROM webysther/composer-debian
MAINTAINER Webysther Nunes <webysther@gmail.com>

WORKDIR /packagist

RUN git clone --depth 1 https://github.com/Webysther/mirror.git .
RUN composer install --no-progress --no-ansi --no-dev --optimize-autoloader
COPY .env .env

VOLUME /public

ENTRYPOINT ["php", "/packagist/bin/mirror", "create"]
CMD ["--no-progress"]
