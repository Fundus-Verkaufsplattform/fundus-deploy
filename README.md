# Fundus Deploy

Docker Setup für Moodle 5.3 mit PostgreSQL und dem Fundus Plugin.

## Lokales Setup

Lege fundus neben dieses Repository und kopiere es in plugin.
Erstelle .env aus .env.example und setze lokale Passwörter.
Baue das Basisimage und danach das Fundus Image. Starte die Dienste mit
docker compose up und installiere Moodle mit bash ./scripts/install.sh.
Die lokale Seite ist unter http://localhost:8080 erreichbar.

## Lokal installieren (Ubuntu WSL)

Führe alle lokalen Installationsbefehle in Ubuntu (WSL), nicht in PowerShell, aus.
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

Konfiguration in Ubuntu WSL anlegen und bearbeiten. Ändere mindestens
`MOODLE_DB_PASSWORD` und `MOODLE_ADMIN_PASS`, bevor du fortfährst:

```bash
cd ~/projects/fundus-deploy
cp -n .env.example .env
nano .env
```

Plugin kopieren, Images bauen und Moodle starten:

```bash
cd ~/projects/fundus-deploy
mkdir -p plugin
cp -r ~/projects/fundus/* plugin/
docker build -t ghcr.io/fundus-verkaufsplattform/fundus-moodle-base:5.3 ./base
docker build -t ghcr.io/fundus-verkaufsplattform/fundus-moodle:local .
docker compose up -d
bash ./scripts/install.sh
```
