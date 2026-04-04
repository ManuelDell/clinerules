# Workflow: Unbekannte Codebasis verstehen

Nutze diesen Workflow wenn du ein Projekt zum ersten Mal siehst oder nach längerem
Context-Compact wieder einsteigen musst. Ziel: Orientierung mit minimalem Token-Verbrauch.

---

## Wann dieser Workflow greift

- Neues Projekt, kein `plans/`-Eintrag vorhanden
- Nach `/compact` in komplexer Session
- Bevor du eine Aufgabe in einer dir unbekannten Dateistruktur anfängst

---

## Schritte

### 1. Einstiegspunkt finden

```bash
# Typische Einstiegspunkte je nach Stack:
ls -la                         # Was liegt im Root?
ls src/ app/ lib/ 2>/dev/null  # Wo ist der Code?

# Häufige Hauptdateien:
# Python:     main.py, app.py, manage.py, __main__.py
# Node/TS:    index.ts, server.ts, app.ts, main.ts
# Go:         main.go, cmd/*/main.go
# Rust:       src/main.rs, src/lib.rs
```

**Lies die Hauptdatei nur bis zur ersten Schicht** — imports/requires zeigen was wichtig ist.

### 2. Verzeichnisstruktur erfassen

```bash
# Nur 2 Ebenen tief — nicht rekursiv in alles
find . -maxdepth 2 -type f -name "*.py" | head -30
find . -maxdepth 2 -type f -name "*.ts" | head -30

# Oder mit Glob-Patterns:
# **/*.py (max 2 Ebenen)
# src/**/*.ts
```

Ziel: Wissen welche Module/Pakete existieren — noch nicht lesen.

### 3. Zentrale Patterns finden

```bash
# Routen / Endpoints:
grep -rn "@app.route\|@router\|app.get\|app.post" --include="*.py" .
grep -rn "router\.\(get\|post\|put\|delete\)" --include="*.ts" .

# Klassen / Services:
grep -rn "^class " --include="*.py" . | head -20
grep -rn "^export class\|^export function" --include="*.ts" . | head -20

# Konfiguration:
ls *.env* *.config* *.yml *.yaml *.toml *.ini 2>/dev/null

# Tests:
ls tests/ test/ spec/ __tests__/ 2>/dev/null
```

### 4. Abhängigkeiten verstehen

```bash
# Python:
cat requirements.txt pyproject.toml setup.py 2>/dev/null | head -40

# Node:
cat package.json | python3 -c "import json,sys; d=json.load(sys.stdin); [print(k) for k in d.get('dependencies',{})]"

# Interne Abhängigkeiten — wer importiert was?
grep -rn "^from \.\|^import \." --include="*.py" . | head -20
grep -rn "from '\.\./\|from '\.\/" --include="*.ts" . | head -20
```

### 5. Gezielt einlesen

Erst jetzt Dateien lesen — aber nur:
- Die Datei die du ändern musst
- Die direkte Eltern-Datei (wer ruft sie auf?)
- Die direkte Kind-Datei (was ruft sie auf?)

**Nicht:** alle Dateien des Moduls lesen weil man "Kontext braucht".

---

## Checkpoint setzen

Nach diesem Workflow: Plan-Datei anlegen oder updaten:

```markdown
## Architektur-Überblick
- Einstiegspunkt: app.py (FastAPI, Uvicorn)
- Module: router/, models/, services/
- Config: .env + config.yaml
- Tests: tests/ (pytest)

## Kritische Dateien für diese Aufgabe
- services/auth.py:42 — login() Funktion
- models/user.py — User-Klasse
```

Dieser Checkpoint überlebt Context-Compact und spart beim nächsten Mal alle Schritte 1–4.
