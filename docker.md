# Docker & Docker Compose Rules

## Häufigste Fehler — Vermeide X, mache Y

**Build**
❌ `docker compose build` wenn kein `build:` im Compose
✅ `docker build -t <image>:<tag> <context>/` direkt aufrufen

❌ Immer `--no-cache` nutzen — langsam, verhindert Layer-Reuse
✅ `--no-cache` nur wenn Cache-Invalidierung nötig (Dependency-Änderungen)

❌ Dateien mit Secrets ins Image kopieren (`COPY .env .`)
✅ Secrets über Env-Vars zur Laufzeit übergeben

**Dockerfile**
❌ `FROM ubuntu` — riesig, langsam, viele unnötige Pakete
✅ `FROM python:3.12-slim` oder `FROM node:20-alpine`

❌ Alles in einem `RUN`-Layer oder jede Zeile einzeln
✅ Zusammengehöriges gruppieren: `RUN apt-get update && apt-get install -y pkg && rm -rf /var/lib/apt/lists/*`

❌ `COPY . .` ganz am Anfang — invalidiert Cache bei jeder Änderung
✅ Dependencies zuerst kopieren und installieren, dann Appcode:
```dockerfile
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
```

**Compose**
❌ Ports ohne Notwendigkeit nach außen exponieren
✅ Interne Services nur im internen Netzwerk, kein `ports:` 

❌ Hardcodierte Werte in `docker-compose.yml`
✅ Alles über `${ENV_VAR:-default}` aus `.env`

❌ Services ohne `healthcheck`
✅ Jeder Service bekommt `healthcheck` mit `test`, `interval`, `timeout`, `retries`

❌ `restart: always` für Development-Services
✅ `restart: unless-stopped` für Production, kein Restart für Dev

## Debugging

```bash
docker logs <container> --tail=50 -f    # Live-Logs
docker exec -it <container> /bin/sh     # Shell öffnen (alpine: sh, nicht bash)
docker inspect <container>              # Details + Netzwerk + Volumes
docker stats                            # CPU/Memory live
```

## Aufräumen

```bash
docker image prune                      # Ungetaggte Images löschen
docker system prune                     # Alles Unbenutzte löschen
```
