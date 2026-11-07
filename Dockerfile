ARG BASE_IMAGE=ghcr.io/fundus-verkaufsplattform/fundus-moodle-base:5.3
FROM ${BASE_IMAGE}

COPY --chown=www-data:www-data plugin/ /var/www/html/public/local/fundus/
