#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

docker compose exec -T moodle php /var/www/html/admin/cli/upgrade.php --non-interactive --allow-unstable
docker compose exec -T moodle php /var/www/html/admin/cli/purge_caches.php
