FROM webysther/composer-debian
MAINTAINER Webysther Nunes <webysther@gmail.com>

WORKDIR /packagist

RUN git clone --depth 1 https://github.com/Webysther/packagist-mirror.git .
RUN composer install --no-progress --no-ansi --no-dev --optimize-autoloader
COPY .env .env

VOLUME /public

ENV SLEEP 15

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# with while access to files keep to memory cache
CMD while sleep $SLEEP; do php bin/mirror create --no-progress; done
