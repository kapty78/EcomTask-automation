# n8n Deployment auf Render

Diese Anleitung erklärt, wie ihr n8n auf Render deployt.

## Voraussetzungen

- Ein Render-Account
- Git-Repository mit dem n8n-Code
- Node.js 22+ Support

## Deployment-Schritte

### 1. Repository auf Render verbinden

1. Geht zu [render.com](https://render.com) und loggt euch ein
2. Klickt auf "New +" und wählt "Web Service"
3. Verbindet euer Git-Repository
4. Wählt den Branch aus (meist `main` oder `master`)

### 2. Service-Konfiguration

**Name:** `n8n-workflow-automation` (oder euer gewünschter Name)
**Environment:** `Node`
**Region:** Wählt die Region, die euch am nächsten ist
**Branch:** `main` (oder euer Standard-Branch)
**Root Directory:** Leer lassen (Root des Repositories)

### 3. Build & Start Commands

**Build Command:**
```bash
npm install -g pnpm@10.12.1
pnpm install
pnpm run build:render
```

**Start Command:**
```bash
cd packages/cli && pnpm start
```

### 4. Umgebungsvariablen

Fügt folgende Umgebungsvariablen hinzu:

#### Erforderliche Variablen:
- `NODE_ENV`: `production`
- `N8N_PORT`: `5678`
- `N8N_PROTOCOL`: `https`
- `N8N_HOST`: `eure-app-url.onrender.com`
- `N8N_BASIC_AUTH_ACTIVE`: `true`
- `N8N_BASIC_AUTH_USER`: `admin` (oder euer gewünschter Benutzername)
- `N8N_BASIC_AUTH_PASSWORD`: Generiert einen sicheren Wert
- `N8N_ENCRYPTION_KEY`: Generiert einen 32-Zeichen-Schlüssel

#### Optionale Variablen:
- `DB_TYPE`: `sqlite` (Standard) oder `postgresdb`
- `GENERIC_TIMEZONE`: `Europe/Berlin`
- `N8N_LOG_LEVEL`: `info`
- `N8N_DIAGNOSTICS_ENABLED`: `false`

### 5. Erweiterte Konfiguration

#### Für PostgreSQL-Datenbank:
1. Erstellt einen neuen PostgreSQL-Service auf Render
2. Fügt die Datenbank-Umgebungsvariablen hinzu:
   - `DB_TYPE`: `postgresdb`
   - `DB_POSTGRESDB_HOST`: Eure DB-Host-URL
   - `DB_POSTGRESDB_DATABASE`: Datenbankname
   - `DB_POSTGRESDB_USER`: Benutzername
   - `DB_POSTGRESDB_PASSWORD`: Passwort

#### Für Redis (Queue Management):
1. Erstellt einen neuen Redis-Service auf Render
2. Fügt die Redis-Umgebungsvariablen hinzu:
   - `QUEUE_BULL_REDIS_HOST`: Redis-Host-URL
   - `QUEUE_BULL_REDIS_PORT`: `6379`
   - `QUEUE_BULL_REDIS_PASSWORD`: Redis-Passwort

### 6. Deployment starten

1. Klickt auf "Create Web Service"
2. Render startet automatisch den Build-Prozess
3. Das erste Deployment kann 5-10 Minuten dauern
4. Überwacht die Build-Logs auf Fehler

### 7. Nach dem Deployment

1. **Erste Anmeldung:**
   - Geht zu eurer App-URL
   - Loggt euch mit den Basic Auth-Credentials ein
   - Erstellt euren ersten Admin-Account

2. **Webhook-URLs aktualisieren:**
   - Alle Webhook-URLs müssen auf eure neue Render-URL zeigen
   - Aktualisiert `WEBHOOK_URL` in den Umgebungsvariablen

3. **SSL-Zertifikat:**
   - Render stellt automatisch SSL-Zertifikate bereit
   - Alle URLs sollten `https://` verwenden

## Troubleshooting

### Häufige Probleme:

1. **Build-Fehler:**
   - Überprüft die Node.js-Version (muss 22+ sein)
   - Stellt sicher, dass alle Dependencies korrekt installiert werden

2. **Start-Fehler:**
   - Überprüft die Umgebungsvariablen
   - Schaut euch die Logs an

3. **Datenbank-Verbindung:**
   - Bei PostgreSQL: Überprüft die Verbindungsdaten
   - Bei SQLite: Stellt sicher, dass der Service Schreibrechte hat

### Logs überprüfen:

- Geht zu eurem Service auf Render
- Klickt auf "Logs"
- Überwacht die Logs während des Deployments

## Kosten

- **Starter Plan:** $7/Monat (512 MB RAM, Shared CPU)
- **Standard Plan:** $25/Monat (1 GB RAM, Dedicated CPU)
- **Pro Plan:** $50/Monat (2 GB RAM, Dedicated CPU)

Für n8n empfehlen wir mindestens den Standard Plan.

## Support

Bei Problemen:
1. Überprüft die Render-Logs
2. Schaut euch die n8n-Dokumentation an
3. Kontaktiert den Render-Support
