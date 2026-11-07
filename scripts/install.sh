#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

set -a
. ./.env
set +a

docker compose exec -T moodle php /var/www/html/admin/cli/install_database.php \
  --agree-license \
  --fullname="${MOODLE_SITE_FULLNAME}" \
  --shortname="${MOODLE_SITE_SHORTNAME}" \
  --adminpass="${MOODLE_ADMIN_PASS}" \
  --adminemail="${MOODLE_ADMIN_EMAIL}"
