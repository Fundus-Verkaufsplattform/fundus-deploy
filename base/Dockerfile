FROM moodlehq/moodle-php-apache:8.4-bookworm
ARG MOODLE_VERSION=5.3
ARG MOODLE_SHA256=7e5edf110555956571f40e42acffde0eb23681ebebd212a2fec0fe7d795dd511
USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL -o /tmp/moodle.tgz \
         "https://packaging.moodle.org/stable503/moodle-${MOODLE_VERSION}.tgz" \
    && echo "${MOODLE_SHA256}  /tmp/moodle.tgz" | sha256sum -c - \
    && tar -xzf /tmp/moodle.tgz -C /var/www/html --strip-components=1 \
    && rm /tmp/moodle.tgz \
    && chown -R www-data:www-data /var/www/html
COPY php.ini /usr/local/etc/php/conf.d/99-moodle.ini
COPY docker-entrypoint.d/ /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.d/*.sh
