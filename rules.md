# OpenRouter AI Stack — Cline Rules

## Stack-Kontext

**Pfad:** `/data/compose/openrouter-ai-stack/`

**Ports (extern):**
- Router API: `8085` → intern `8080`
- Memory Service: `8086` → intern `8081`
- MCP Server: `8087` → intern `8082`
- Open WebUI: `8088` → intern `8080`

**Model-IDs für Cline (in das Model-Feld eingeben):**
- Coding: `titan` | `professional` | `flitzer` (auch: `profi`, `coding-titan`, etc.)
- Chat: `denker` | `allrounder` | `begleiter`
- Auto-Routing: leer lassen oder `auto`

**Kritische Dateien — immer zuerst lesen bevor du änderst:**
- `.env` — API-Keys, Ports, Modell-Konfiguration
- `services/router/app.py` — Haupt-Router-Logik
- `services/router/models/class_router.py` — Modell-Klassen und Tier-System
- `docker-compose.yml` — Service-Definitionen und Env-Vars

---

## Build & Deploy

**Images bauen** — KEIN `docker compose build` verwenden (kein `build:` im Compose):
```bash
docker build -t openrouter-ai-stack/<service>:local services/<service>/
```

**Service neustarten:**
```bash
docker compose up -d <service>
```

**Beides zusammen (Standard-Workflow):**
```bash
docker build -t openrouter-ai-stack/router:local services/router/ && docker compose up -d ai-router
```

**Service-Namen:** `ai-router` | `memory-svc` | `mcp-server` | `open-webui` | `redis` | `ai-searxng` | `bash-executor`

---

## Coding-Prinzipien

**Single Responsibility** — Jede Funktion/Klasse macht genau eine Sache.
Wenn du "und" brauchst um zu beschreiben was sie tut, aufteilen.

**Open/Closed** — Neues Verhalten durch neue Funktionen oder Module,
nie durch Änderungen in bestehender funktionierender Logik.

**DRY** — Logik existiert genau einmal. Mehr als 2 kopierte Zeilen → Helper extrahieren.
Model-IDs, URLs, Schwellenwerte kommen aus Env-Vars, nie als Literals.

**KISS** — Einfachsten Code schreiben der funktioniert. Flat function > class. Dict > ORM.
Keine spekulativen Abstraktionen. Keine vorzeitige Optimierung.

**Dependency Inversion** — Abhängigkeiten auf Abstraktionen (Env-Vars, Base-URLs),
nicht auf konkrete Implementierungen (hardcodierte Modellnamen, direkte DB-Pfade).

---

## Projekt-Regeln

- Neue Services → `services/<name>/`
- Jeder neue Endpoint braucht `/health` oder ist über `/health` des Routers erreichbar
- Kosten werden nach **jedem** OpenRouter API-Call getrackt — nie überspringen
- Alle Konfiguration über Env-Vars — nichts hardcoden
- Neue Images pushen nach: `ghcr.io/manueldell/openrouter-ai-stack/<name>:latest`
- Dispatchers sind zustandslos — kein globaler mutabler State

---

## Was du NICHT tun sollst

- `docker compose build` aufrufen — funktioniert nicht (kein `build:` in compose)
- `.env` mit `write_to_file` überschreiben — immer `edit_file` nutzen
- Modellnamen hardcoden — immer Env-Vars oder class_router.py-Defaults
- Tests mocken die eigentlich echte Services testen sollten
- Features hinzufügen die nicht explizit angefragt wurden
