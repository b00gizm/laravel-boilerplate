#!/bin/bash

export VERSION=`php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;"` \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/${VERSION} \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so ${PHP_EXT_DIR}/blackfire.so \
    && echo "extension=blackfire.so" > ${PHP_INI_DIR}/conf.d/blackfire.ini \
    && echo "blackfire.agent_socket=${BLACKFIRE_1_PORT_8707_TCP}" >> ${PHP_INI_DIR}/conf.d/blackfire.ini \
    && echo "blackfire.server_id=${BLACKFIRE_ENV_BLACKFIRE_SERVER_ID}" >> ${PHP_INI_DIR}/conf.d/blackfire.ini \
    && echo "blackfire.server_token=${BLACKFIRE_ENV_BLACKFIRE_SERVER_TOKEN}" >> ${PHP_INI_DIR}/conf.d/blackfire.ini \
    && echo "blackfire.log_file=/tmp/blackfire.log" >> ${PHP_INI_DIR}/conf.d/blackfire.ini \
    && echo "blackfire.log_level=${BLACKFIRE_ENV_BLACKFIRE_LOG_LEVEL}" >> ${PHP_INI_DIR}/conf.d/blackfire.ini

# Function to update the fpm configuration to make the service environment variables available
function setEnvironmentVariable() {

    if [ -z "$2" ]; then
            echo "Environment variable '$1' not set."
            return
    fi

    echo "env[$1] = $2" >> /etc/php5/fpm/pool.d/www.conf
}

# Grep for variables that look like docker set them (_PORT_)
for _curVar in `env | grep _PORT_ | awk -F = '{print $1}'`;do
    # awk has split them by the equals sign
    # Pass the name and value to our function
    setEnvironmentVariable ${_curVar} ${!_curVar}
done

service php5-fpm start && nginx
