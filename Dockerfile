FROM php:7.0-cli

RUN apt-get update && \
    apt-get install -y wget && \
    echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
    echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
    wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add -

RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
      libmcrypt-dev \
      libbz2-dev \
      zlib1g-dev \
      sqlite3 \
      libsqlite3-dev \
      curl \
      git \
      php7.0-sqlite3 \
      php7.0-redis \
      && \
    docker-php-ext-install mcrypt zip bz2 mbstring && \
    docker-php-ext-enable opcache && \
    echo "opcache.enable_cli = On" > /usr/local/etc/php/conf.d/opcache-cli.ini && \
    echo "date.timezone = $TZ" > /usr/local/etc/php/conf.d/timezone.ini && \
    echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory_limit.ini && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require hirak/prestissimo && \
    mkdir -p ~/.ssh /root/.ssh /etc/ssh

CMD ["php"]
