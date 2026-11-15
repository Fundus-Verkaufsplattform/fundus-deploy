# Fundus Deploy

Docker Setup für Moodle 5.3 mit PostgreSQL und dem Fundus Plugin.

## Lokal installieren (Ubuntu WSL)

Führe die lokalen Installationsbefehle in Ubuntu (WSL), nicht in PowerShell, aus.
Docker Desktop muss laufen und die WSL-Integration für Ubuntu aktiviert sein.
Lege die Repositories im Linux-Dateisystem unter `~/projects` ab.

Repositories klonen:

```bash
mkdir -p ~/projects
cd ~/projects
git clone https://github.com/Fundus-Verkaufsplattform/fundus-deploy.git
git clone https://github.com/Fundus-Verkaufsplattform/fundus.git
cd ~/projects/fundus-deploy
```

## Konfiguration

Erstelle `.env` aus `.env.example` und setze lokale Passwörter. Ändere mindestens
`MOODLE_DB_PASSWORD` und `MOODLE_ADMIN_PASS`, bevor du fortfährst:

```bash
cd ~/projects/fundus-deploy
cp -n .env.example .env
code .env
```

## Moodle starten

Kopiere das Plugin für den ersten Image-Build und starte Moodle:

```bash
cd ~/projects/fundus-deploy
mkdir -p plugin
cp -r ~/projects/fundus/* plugin/
docker build -t ghcr.io/fundus-verkaufsplattform/fundus-moodle-base:5.3 ./base
docker build -t ghcr.io/fundus-verkaufsplattform/fundus-moodle:local .
docker compose -f compose.yml -f compose.dev.yml up -d
bash ./scripts/install.sh
```

`compose.dev.yml` bindet das Plugin-Repository direkt in die Moodle- und Cron-
Container ein. Beim Entwickeln werden Änderungen so direkt verwendet; erneutes
Kopieren und Bauen des Images ist nicht nötig. Den Override nur lokal verwenden.
Auf dem Server startest du mit `docker compose up -d`.

Die lokale Moodle-Seite ist unter http://localhost:8080 erreichbar. Das Fundus-
Plugin rufst du nach der Anmeldung unter
[http://localhost:8080/local/fundus/index.php](http://localhost:8080/local/fundus/index.php) auf.
