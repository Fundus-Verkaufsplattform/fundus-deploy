# Fundus Deploy

Docker Setup für Moodle 5.3 mit PostgreSQL und dem Fundus Plugin.

## Lokales Setup

Lege fundus neben dieses Repository und kopiere es in plugin.
Erstelle .env aus .env.example und setze lokale Passwörter.
Baue das Basisimage und danach das Fundus Image. Starte die Dienste mit
docker compose up und installiere Moodle mit ./scripts/install.sh.
Die lokale Seite ist unter http://localhost:8080 erreichbar.
