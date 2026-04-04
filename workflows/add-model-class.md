# Workflow: Neue Modell-Klasse hinzufügen

Nutzen wenn: Eine neue Klasse (z.B. `spezialist`) mit 3-Tier-Fallback hinzugefügt werden soll.

## Schritte

1. **`services/router/models/class_router.py` — `MODEL_CLASSES` ergänzen:**
   ```python
   "spezialist": [
       {"model": os.getenv("SPEZIALIST_FREE1", "model-id:free"), "limit": 20, "tools": True},
       {"model": os.getenv("SPEZIALIST_FREE2", "backup-model:free"), "limit": 10, "tools": False},
       {"model": os.getenv("SPEZIALIST_PAID",  "paid-model"),        "limit": None, "tools": True},
   ],
   ```
   - `limit`: Tages-Maximum für Free-Tiere (None = kein Limit = Paid)
   - `tools`: True wenn das Modell OpenAI Tool-Calling unterstützt

2. **`ALIASES` dict ergänzen:**
   ```python
   "spezialist": "spezialist",
   "mein-spezialist": "spezialist",
   ```

3. **Einordnen: Coding oder Chat?**
   - Coding (nur IDE/Cline): `CODING_CLASSES` in `class_router.py` ergänzen
   - Chat (OWT-Dropdown): in `list_models()` in `app.py` hinzufügen:
     ```python
     {"id": "spezialist", "object": "model", "owned_by": "router", "role": "chat-spezialist"},
     ```

4. **`.env` — 3 neue Vars hinzufügen:**
   ```
   SPEZIALIST_FREE1=model-id:free
   SPEZIALIST_FREE2=backup-model:free
   SPEZIALIST_PAID=paid-model
   ```

5. **`docker-compose.yml` — Vars beim `ai-router` Service eintragen:**
   ```yaml
   - SPEZIALIST_FREE1=${SPEZIALIST_FREE1:-model-id:free}
   - SPEZIALIST_FREE2=${SPEZIALIST_FREE2:-backup-model:free}
   - SPEZIALIST_PAID=${SPEZIALIST_PAID:-paid-model}
   ```

6. **Verfügbare Free-Modelle prüfen** (vor Deployment):
   ```bash
   curl -s "https://openrouter.ai/api/v1/models" \
     -H "Authorization: Bearer $OPENROUTER_API_KEY" | \
     python3 -c "import json,sys; [print(m['id']) for m in json.load(sys.stdin)['data'] if ':free' in m['id']]"
   ```

7. **Router neu deployen** (siehe Workflow `deploy-router`)

## Wichtig
- `:free`-Modelle auf OpenRouter erfordern manchmal ein Mindestguthaben (~$1) — bei 402-Fehlern ist das die Ursache
- Der Router fällt bei Laufzeitfehlern automatisch durch die Tier-Kette (Free1 → Free2 → Paid → Global-Fallback)
