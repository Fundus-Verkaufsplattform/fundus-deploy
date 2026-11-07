#!/bin/sh
set -eu

CONFIG=/var/www/html/config.php

if [ -f "$CONFIG" ]; then
  echo "config.php already exists, skipping generation"
  exit 0
fi

: "${MOODLE_DB_TYPE:=pgsql}"
: "${MOODLE_DB_HOST:=db}"
: "${MOODLE_DB_NAME:=moodle}"
: "${MOODLE_DB_USER:=moodle}"
: "${MOODLE_DB_PASSWORD:?MOODLE_DB_PASSWORD is required}"
: "${MOODLE_WWWROOT:=http://localhost:8080}"
: "${MOODLE_DATAROOT:=/var/www/moodledata}"
: "${MOODLE_REVERSE_PROXY:=false}"
: "${MOODLE_SSL_PROXY:=false}"
: "${MOODLE_ROUTER_CONFIGURED:=false}"

escape() {
  printf '%s' "$1" | sed "s/'/\\\\'/g"
}

cat > "$CONFIG" <<EOF
<?php
unset(\$CFG);
global \$CFG;
\$CFG = new stdClass();

\$CFG->dbtype    = '$(escape "$MOODLE_DB_TYPE")';
\$CFG->dblibrary = 'native';
\$CFG->dbhost    = '$(escape "$MOODLE_DB_HOST")';
\$CFG->dbname    = '$(escape "$MOODLE_DB_NAME")';
\$CFG->dbuser    = '$(escape "$MOODLE_DB_USER")';
\$CFG->dbpass    = '$(escape "$MOODLE_DB_PASSWORD")';
\$CFG->prefix    = 'mdl_';
\$CFG->dboptions = [];

\$CFG->wwwroot   = '$(escape "$MOODLE_WWWROOT")';
\$CFG->dataroot  = '$(escape "$MOODLE_DATAROOT")';
\$CFG->admin     = 'admin';
\$CFG->directorypermissions = 02777;
\$CFG->reverseproxy = filter_var('$(escape "$MOODLE_REVERSE_PROXY")', FILTER_VALIDATE_BOOLEAN);
\$CFG->sslproxy = filter_var('$(escape "$MOODLE_SSL_PROXY")', FILTER_VALIDATE_BOOLEAN);
\$CFG->routerconfigured = filter_var('$(escape "$MOODLE_ROUTER_CONFIGURED")', FILTER_VALIDATE_BOOLEAN);

require_once(__DIR__ . '/lib/setup.php');
EOF

chown www-data:www-data "$CONFIG"
chmod 0640 "$CONFIG"
echo "config.php created"
