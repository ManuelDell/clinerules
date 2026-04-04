# Workflow: Router deployen

Nutzen wenn: Änderungen an `services/router/` gemacht wurden und deployed werden sollen.

## Schritte

1. **Sicherstellen dass alle Änderungen gespeichert sind**

2. **Image neu bauen:**
   ```bash
   docker build -t openrouter-ai-stack/router:local services/router/
   ```

3. **Service neustarten:**
   ```bash
   docker compose up -d ai-router
   ```

4. **Startup-Logs prüfen** (auf Fehler achten):
   ```bash
   docker logs ai-router --tail=20
   ```

5. **Health-Check:**
   ```bash
   curl http://localhost:8085/health
   ```
   Erwartete Antwort: `{"status":"ok","service":"ai-router"}`

6. **Optional — Modell-Status prüfen:**
   ```bash
   curl http://localhost:8085/v1/models/status | python3 -m json.tool
   ```

## Häufige Fehler

- `ModuleNotFoundError` → Neue Datei wurde nicht im Dockerfile mit `COPY` erfasst
- `ImportError` → Dependency fehlt in `requirements.txt`
- Service startet nicht → `docker logs ai-router` lesen, meist fehlende Env-Var
