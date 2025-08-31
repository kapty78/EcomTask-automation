# n8n Docker Deployment auf Render

Diese Anleitung erklärt, wie ihr n8n mit Docker auf Render deployt.

## Voraussetzungen

- Ein Render-Account
- Git-Repository mit dem n8n-Code
- Docker-Support auf Render

## Deployment-Schritte

### 1. Repository auf Render verbinden

1. Geht zu [render.com](https://render.com) und loggt euch ein
2. Klickt auf "New +" und wählt "Web Service"
3. Verbindet euer Git-Repository: `kapty78/EcomTask-automation`
4. Wählt den Branch aus (meist `main`)

### 2. Service-Konfiguration

**Name:** `n8n-workflow-automation` (oder euer gewünschter Name)
**Environment:** `Docker`
**Region:** Wählt die Region, die euch am nächsten ist
**Branch:** `main`
**Root Directory:** Leer lassen (Root des Repositories)

### 3. Docker-Konfiguration

**Dockerfile Path:** `./Dockerfile`
- Das Dockerfile erweitert das offizielle `n8nio/n8n:1.74.1` Image
- Eure Branding-Dateien werden automatisch eingebaut
- Port 5678 wird exponiert
- Health Check ist konfiguriert

### 4. Umgebungsvariablen

Die wichtigsten Variablen werden automatisch gesetzt:
- **N8N_HOST:** Eure Render-URL
- **N8N_PORT:** 5678
- **N8N_PROTOCOL:** https
- **WEBHOOK_URL:** Eure Render-URL
- **Datenbank:** Automatisch mit der Postgres-DB verbunden

### 5. Datenbank

- **PostgreSQL-Datenbank** wird automatisch erstellt
- **Persistenter Speicher** wird bei `/home/node/.n8n` gemountet
- **SSL-Verbindung** ist konfiguriert

### 6. Branding anpassen

Um eure eigenen Logos zu verwenden:

1. **Favicon ersetzen:** `branding/favicon.ico`
2. **Logo ersetzen:** `branding/logo.svg`
3. **Robots.txt anpassen:** `branding/robots.txt`
4. **Änderungen committen und pushen**

### 7. Deployment starten

1. Klickt auf "Create Web Service"
2. Render baut das Docker-Image
3. Der Service startet automatisch
4. Eure n8n-Instanz ist unter der Render-URL erreichbar

## Features

✅ **Docker-basiert** - Konsistente Umgebung
✅ **Custom Branding** - Eure Logos und Favicons
✅ **PostgreSQL-Datenbank** - Robuste Datenspeicherung
✅ **Persistenter Speicher** - Workflows bleiben erhalten
✅ **Health Checks** - Automatische Überwachung
✅ **SSL/HTTPS** - Sichere Verbindungen
✅ **Automatische Skalierung** - Render kümmert sich um alles

## Troubleshooting

### Service startet nicht
- Überprüft die Logs in Render
- Stellt sicher, dass alle Umgebungsvariablen gesetzt sind

### Branding wird nicht angezeigt
- Überprüft, ob die Dateien im `branding/` Ordner sind
- Stellt sicher, dass die Dateien committet und gepusht wurden

### Datenbank-Verbindung fehlschlägt
- Überprüft, ob die Postgres-DB läuft
- Stellt sicher, dass alle DB-Umgebungsvariablen korrekt sind

## Support

Bei Problemen:
1. Überprüft die Render-Logs
2. Stellt sicher, dass alle Dateien korrekt sind
3. Kontaktiert den Support bei Render-spezifischen Problemen
