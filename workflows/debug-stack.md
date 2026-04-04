# Workflow: Stack debuggen

## Health-Checks

```bash
# Alle Services auf einmal
curl http://localhost:8085/health   # Router
curl http://localhost:8086/health   # Memory Service
curl http://localhost:8087/health   # MCP Server

# Docker-Status
docker compose ps
```

## Logs

```bash
docker logs ai-router --tail=50      # Router
docker logs ai-memory --tail=50      # Memory Service
docker logs ai-mcp --tail=50         # MCP Server
docker logs ai-webui --tail=50       # Open WebUI

# Live-Logs
docker logs ai-router -f
```

## Modell-Status (Tier-Verbrauch heute)

```bash
curl http://localhost:8085/v1/models/status | python3 -m json.tool
```

Zeigt für jede Klasse welches Tier aktiv ist und wie viele Requests heute schon genutzt wurden.

## Redis inspizieren

```bash
# Redis CLI öffnen
docker exec -it ai-redis redis-cli -a $REDIS_PASSWORD

# Alle model_usage Keys heute
KEYS model_usage:*:$(date +%Y-%m-%d)

# Spezifischen Counter prüfen
GET "model_usage:nousresearch/hermes-3-llama-3.1-405b:free:$(date +%Y-%m-%d)"

# Counter manuell zurücksetzen (für Tests)
DEL "model_usage:nousresearch/hermes-3-llama-3.1-405b:free:$(date +%Y-%m-%d)"
```

## Router-Routing testen (ohne echten API-Call)

```bash
curl -X POST http://localhost:8085/route-info \
  -H "Content-Type: application/json" \
  -d '{"messages":[{"role":"user","content":"Erkläre mir diesen Code"}]}'
```

## OWT-Dropdown prüfen

```bash
curl http://localhost:8085/v1/models | python3 -m json.tool
```

Sollte zeigen: `auto`, `denker`, `allrounder`, `begleiter` (keine Coding-Klassen).

## Häufige Probleme

| Symptom | Ursache | Fix |
|---|---|---|
| 402 von OpenRouter | Free-Modell braucht Mindestguthaben | Router fällt automatisch auf nächsten Tier |
| 404 von OpenRouter | Modell-ID existiert nicht | `.env` mit korrekter ID aktualisieren |
| Socket-Fehler in Cline | Timeout bei langsamen Free-Modellen | Automatischer Tier-Fallback, nochmal versuchen |
| `ModuleNotFoundError` | Neue Datei nicht in Dockerfile | `COPY <datei>` in `services/router/Dockerfile` |
| Memory bleibt `default` | OWT-API-Key nicht konfiguriert | In OWT Admin → API Keys aktivieren |
