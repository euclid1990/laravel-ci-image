FROM circleci/php:7.2.17-fpm-stretch

USER root
ENV DEBIAN_FRONTEND noninteractive

# Install os packages
RUN rm -rf /var/lib/apt/lists/* && \
    apt-get update && apt-get install -y \
    sudo \
    g++ \
    zip \
    vim \
    curl \
    telnet \
    postfix \
    mailutils \
    memcached \
    sasl2-bin \
    libpq-dev \
    libmemcached-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libmcrypt-dev \
    libicu-dev \
    libsqlite3-dev \
    libssl-dev \
    libcurl3-dev \
    libxml2-dev \
    libzzip-dev \
    libpcre3-dev \
    libzip-dev \
    liblz4-dev \
    libevent-dev \
    libsasl2-2 \
    libsasl2-dev \
    libsasl2-modules \
    --no-install-recommends apt-utils \
    && rm -r /var/lib/apt/lists/*

# Configure GD library
RUN docker-php-ext-configure gd \
    --enable-gd-native-ttf \
    --with-jpeg-dir=/usr/lib \
    --with-freetype-dir=/usr/include/freetype2

# Install mongodb, xdebug, memcached, mcrypt
RUN pecl install mongodb xdebug memcached-3.1.3 mcrypt-1.0.2 memcached-3.1.3 \
    && docker-php-ext-enable mongodb xdebug memcached mcrypt

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install \
    gd \
    bcmath \
    pdo_mysql \
    pdo_pgsql \
    zip \
    mysqli

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Make composer global
RUN chmod 755 /usr/local/bin/composer

COPY circleci/php/php.ini /usr/local/etc/php/php.ini

COPY circleci/php/php-fpm.conf /usr/local/etc/php-fpm.conf

COPY circleci/php/www.conf /usr/local/etc/php-fpm.d/www.conf

COPY circleci/*.sh /scripts/

RUN chmod a+x /scripts/*.sh

EXPOSE 9000

USER circleci

COPY phpcs /home/circleci/phpcs

RUN sudo chown -R circleci:circleci /scripts/*.sh

ENTRYPOINT ["/scripts/entrypoint.sh"]
