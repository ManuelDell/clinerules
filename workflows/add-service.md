# Workflow: Neuen Service zum Stack hinzufügen

## Schritte

1. **Verzeichnis anlegen:**
   ```bash
   mkdir -p services/<name>/
   ```

2. **Dockerfile schreiben** (`services/<name>/Dockerfile`):
   ```dockerfile
   FROM python:3.12-slim
   WORKDIR /app
   COPY requirements.txt .
   RUN pip install --no-cache-dir -r requirements.txt
   COPY app.py .
   EXPOSE 8080
   CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]
   ```

3. **`requirements.txt` anlegen** mit benötigten Paketen

4. **`app.py` schreiben** — FastAPI mit Pflicht-Endpoint:
   ```python
   @app.get("/health")
   async def health():
       return {"status": "ok", "service": "<name>"}
   ```

5. **Image bauen:**
   ```bash
   docker build -t openrouter-ai-stack/<name>:local services/<name>/
   ```

6. **`docker-compose.yml` ergänzen:**
   ```yaml
   <name>:
     <<: *common
     image: openrouter-ai-stack/<name>:local
     container_name: ai-<name>
     environment:
       - LOG_LEVEL=${LOG_LEVEL:-INFO}
     healthcheck:
       test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
       interval: 15s
       timeout: 5s
       retries: 3
   ```

7. **`.env` erweitern** mit allen Env-Vars des neuen Services

8. **Service starten:**
   ```bash
   docker compose up -d <name>
   ```

## Checkliste
- [ ] `/health` Endpoint vorhanden
- [ ] Alle Konfiguration über Env-Vars (nichts hardcoded)
- [ ] `docker-compose.yml` hat healthcheck
- [ ] `.env` hat alle neuen Vars dokumentiert
