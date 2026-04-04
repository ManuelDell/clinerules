# Python Rules

## Häufigste Fehler — Vermeide X, mache Y

**Fehlerbehandlung**
❌ `except Exception: pass` — Fehler verschwindet lautlos
✅ Spezifische Exception fangen, loggen oder re-raisen: `except ValueError as e: log.error(e); raise`

**Mutable Default Args**
❌ `def f(items=[])` — wird zwischen Aufrufen geteilt
✅ `def f(items=None): items = items or []`

**Async**
❌ `time.sleep(1)` in async-Funktion — blockiert den Event Loop
✅ `await asyncio.sleep(1)`
❌ Synchrone DB/HTTP-Calls in `async def` ohne `await`
✅ Async-Bibliothek nutzen (httpx, aioredis, asyncpg statt requests, redis, psycopg2)

**String-Operationen**
❌ `result = ""` + Schleife mit `result += s`
✅ `result = "".join(parts)`

**Dateien**
❌ `f = open(path)` ohne `with`
✅ `with open(path) as f:` — immer Context Manager

**Importe**
❌ `from module import *`
✅ Explizite Imports. Reihenfolge: stdlib → third-party → lokal (PEP8)

**Pfade**
❌ `os.path.join(dir, "file.txt")`
✅ `pathlib.Path(dir) / "file.txt"`

**Type Hints**
❌ Keine Annotations bei Funktionssignaturen
✅ `def process(data: list[str]) -> dict[str, int]:` — immer bei public functions

## Prinzipien

- **Stdlib zuerst** — `itertools`, `collections`, `functools` lösen mehr als gedacht
- **Kein globaler mutabler State** — State als Parameter übergeben
- **Logging statt print** — `import logging; log = logging.getLogger(__name__)`
- **Früh scheitern** — Input validieren am Eingang, nicht mittendrin
- **Comprehensions für Transformationen** — `[x*2 for x in items if x > 0]` statt Schleife mit append

## Verboten

- `eval()` und `exec()` — außer explizit gefordert
- `global` für State-Management
- `bare except:` (ohne Exception-Typ)
