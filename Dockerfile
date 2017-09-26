FROM composer
MAINTAINER Webysther Nunes <webysther@gmail.com>

WORKDIR /packagist

RUN git clone https://github.com/Webysther/mirror.git mirror
RUN cd mirror && composer install --no-progress --no-ansi --no-dev --optimize-autoloader
RUN cp /packagist/mirror/.env.example /packagist/mirror/.env

VOLUME /public

CMD cd /packagist/mirror && php bin/mirror create --no-progress --no-ansi
