FROM naneau/php:5.5

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y nodejs npm ruby
RUN apt-get install -y libnotify-bin

ENV PHP_VERSION  5.5.17
ENV PHP_INI      /usr/local/php/$PHP_VERSION/etc/php.ini

RUN sed -i "s/;date.timezone =/date.timezone = Europe\/Berlin/" $PHP_INI

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

# Install Node.js dependencies
WORKDIR /code/app
RUN npm install
