FROM naneau/php:5.5

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y nodejs npm ruby
RUN apt-get install -y libnotify-bin
RUN apt-get install -y php5-fpm php5-mcrypt
RUN apt-get install -y nginx

ENV PHP_VERSION  5.5.17
ENV PHP_INI      /usr/local/php/$PHP_VERSION/etc/php.ini

RUN sed -i "s/;date.timezone =/date.timezone = Europe\/Berlin/" $PHP_INI

RUN php5enmod mcrypt

# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Install Laravel
RUN composer global require "laravel/installer=~1.2"
ENV PATH /root/.composer/vendor/bin:$PATH

# Install Gulp
RUN ln -s /usr/bin/nodejs /usr/local/bin/node
RUN npm install -g gulp browserify

# Install Ruby Sass
RUN gem install sass

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini
RUN sed -i "s/display_errors = Off/display_errors = On/" /etc/php5/fpm/php.ini

RUN rm /etc/nginx/sites-enabled/default
ADD nginx/sites-enabled/ /etc/nginx/sites-enabled

WORKDIR /code/app

RUN useradd -d /code/app -u 1000 www && \
    sed -i 's/www-data/www/g' /etc/nginx/nginx.conf && \
    sed -i "s/www-data/www/g" /etc/php5/fpm/pool.d/www.conf && \
    sed -i "s/www-data/www/g" /etc/php5/fpm/pool.d/www.conf && \
    chown -R www:www \
        /var/log/nginx \
        /code/app

CMD service php5-fpm start && nginx
