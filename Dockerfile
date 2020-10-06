# using this awesome prebuild image:
FROM '123majumundur/php-7.1-nginx:cicd'
MAINTAINER ZD Rakha <rakhazharfarizqi25@gmail.com>

# Install prestissimo for faster deps installation
RUN composer global require hirak/prestissimo

# Make directory for hosting the apps
RUN mkdir /home/app/app
WORKDIR /home/app/app

# Install dependencies
COPY composer.json composer.json
RUN composer install --prefer-dist --no-scripts --no-dev --no-autoloader && rm -rf /home/app/.composer

# Copy codebase
COPY --chown=app:robot . ./



# Finish composer
#RUN composer dump-autoload
RUN composer dump-autoload --no-scripts --no-dev --optimize

EXPOSE 8080