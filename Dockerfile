FROM php:7.2-apache

# install mysql-client and curl for our data init script
# install the PHP extension pdo_mysql for our connection script
# clean up
RUN apt-get update \
  && apt-get install -y apt-transport-https \
  &&  apt-get install -y --no-install-recommends mariadb-client curl libicu-dev git imagemagick \
  && docker-php-ext-install -j "$(nproc)" intl mbstring mysqli opcache \
  && pecl install apcu-5.1.18 \
  && docker-php-ext-enable apcu \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives

RUN set -eux; \
        curl -fSL "https://releases.wikimedia.org/mediawiki/1.34/mediawiki-1.34.2.tar.gz" -o ~/mediawiki.tar.gz; \
        mkdir ~/mediawiki; \
        tar -xf ~/mediawiki.tar.gz -C ~/mediawiki --strip-components=1; \
        rm ~/mediawiki.tar.gz; \
        mkdir /var/www/html/mediawiki; \
        mv ~/mediawiki/* /var/www/html/mediawiki;

