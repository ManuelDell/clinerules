# API-Calls Rule

## Häufigste Fehler — Vermeide X, mache Y

**Fehlerbehandlung**
❌ `response = requests.get(url)` — kein Timeout, kein Fehlercheck
✅ Immer Timeout + Status-Check:
```python
response = requests.get(url, timeout=10)
response.raise_for_status()
```

❌ HTTP 2xx annehmen wenn kein Exception → aber 204 hat keinen Body
✅ Status-Code explizit prüfen wenn Body erwartet wird

**Secrets**
❌ API-Keys im Code: `api_key = "sk-abc123"`
✅ Aus Env-Var: `api_key = os.environ["API_KEY"]` — fehlt die Var → expliziter Fehler beim Start

❌ API-Keys in Logs: `log.info(f"Calling API with key {api_key}")`
✅ Keys nie loggen — nur Prefix: `log.info("Calling API with key sk-...%s", api_key[-4:])`

**Rate Limiting**
❌ Retry-Loop ohne Backoff bei 429
✅ Exponential Backoff: warte 1s, 2s, 4s... nach 429-Response

❌ Parallele Requests ohne Limit
✅ `asyncio.Semaphore(n)` für max n gleichzeitige Requests

**JSON**
❌ `json.loads(response.text)` — bricht bei leerem Body
✅ `response.json()` mit Try/Except oder erst `if response.content:`

**Pagination**
❌ Nur erste Seite laden und annehmen alles ist da
✅ Pagination-Loop implementieren bis `next_cursor` / `has_more` / leere Liste

## Struktur für API-Calls

```python
BASE_URL = os.getenv("API_BASE_URL")     # Nie hardcoden
API_KEY  = os.environ["API_KEY"]         # Pflicht-Var: crash wenn fehlt

def _headers() -> dict:
    return {"Authorization": f"Bearer {API_KEY}"}

async def call_api(endpoint: str, payload: dict) -> dict:
    async with httpx.AsyncClient(timeout=30.0) as client:
        resp = await client.post(f"{BASE_URL}/{endpoint}",
                                  headers=_headers(), json=payload)
        resp.raise_for_status()
        return resp.json()
```

## Allgemein

- Timeouts immer setzen (connect + read getrennt konfigurieren bei langen Streams)
- Retry-Logik nur für transiente Fehler (429, 503) — nie für 4xx Client-Fehler
- API-Responses nie direkt vertrauen — Felder können fehlen oder anderen Typ haben
- Kosten-/Rate-Limits in der Dokumentation prüfen bevor du eine Schleife baust
