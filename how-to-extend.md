# Roo Rules erweitern — Rules, Hooks, Workflows

Dieses Repository ist darauf ausgelegt einfach erweiterbar zu sein.
Hier steht wie du jeden Typ hinzufügst.

---

## Rule erstellen

**Wann:** Du willst Roo dauerhaft auf ein Thema / eine Technologie hinweisen.

**Datei:** `<name>.md` im Repo-Root (wird via `setup.sh` in `.roorules_helper/` verfügbar)

Für **mode-spezifische** Rules:
- Gilt nur im Architect-Modus → `architect-mode.md` erweitern
- Gilt nur im Code-Modus → `code-mode.md` erweitern
- Gilt für alle Modi → neue `.md`-Datei + Eintrag in `rules.md`

**Format:**
```markdown
# <Thema> Rule

## Häufigste Fehler — Vermeide X, mache Y

❌ Was man nicht tun soll
✅ Was man stattdessen tun soll

## Typischer Workflow

\`\`\`bash
befehl-1
befehl-2
\`\`\`

## Weitere Abschnitte nach Bedarf
```

**Danach:** In `rules.md` in der Referenz-Tabelle eintragen:
```markdown
| Situation          | Datei                            |
|--------------------|----------------------------------|
| Mein neues Thema   | `.roorules_helper/mein-thema.md` |
```

---

## Hook erstellen

**Wann:** Du willst automatisch auf ein Tool-Event reagieren (blockieren, Context anreichern, loggen).

**Datei:** `hooks/<event-name>` — **kein** `.sh`-Suffix, ausführbar machen:
```bash
chmod +x hooks/<event-name>
```

**Verfügbare Events:**
| Event           | Wann                              | Kann blockieren? |
|-----------------|-----------------------------------|------------------|
| `task-start`    | Beim Start jeder Roo-Session      | Nein (nur Context) |
| `pre-tool-use`  | Vor jedem Tool-Aufruf             | Ja               |
| `post-tool-use` | Nach jedem Tool-Aufruf            | Nein             |
| `task-complete` | Am Ende einer Roo-Session         | Nein             |

**Input (stdin):** JSON mit `tool` und `params`:
```json
{
  "tool": "write_to_file",
  "params": {
    "path": "/pfad/zur/datei",
    "content": "..."
  }
}
```

**Output (stdout):**
```bash
# Erlauben:
echo '{"cancel": false}'

# Blockieren (nur pre-tool-use):
echo '{"cancel": true, "errorMessage": "Grund warum blockiert"}'

# Context hinzufügen (task-start):
echo "{\"cancel\": false, \"contextModification\": \"Text der in Context eingefügt wird\"}"
```

**Beispiel-Skeleton:**
```bash
#!/bin/bash
INPUT=$(cat)

TOOL=$(echo "$INPUT" | python3 -c "
import json, sys
try:
    d = json.load(sys.stdin)
    print(d.get('tool', ''))
except:
    print('')
" 2>/dev/null)

FILE=$(echo "$INPUT" | python3 -c "
import json, sys
try:
    d = json.load(sys.stdin)
    p = d.get('params', {})
    print(p.get('path', p.get('file_path', '')))
except:
    print('')
" 2>/dev/null)

# Deine Logik hier
echo '{"cancel": false}'
```

Nach Erstellung: `setup.sh` ausführen damit der Hook in `.roorules/hooks/` landet.

---

## Workflow erstellen

**Wann:** Du willst einen Prozess mit mehreren Schritten dokumentieren (Checkliste, Befehlsabfolge).

**Datei:** `workflows/<name>.md`

**Format:**
```markdown
# Workflow: <Name>

Kurze Beschreibung — wann nutzt man diesen Workflow.

## Wann dieser Workflow greift
- Situation A
- Situation B

## Schritte

### 1. Erster Schritt
Was zu tun ist, mit konkreten Befehlen:
\`\`\`bash
befehl
\`\`\`

### 2. Zweiter Schritt
...

## Schnell-Checkliste
\`\`\`
[ ] Schritt 1
[ ] Schritt 2
\`\`\`
```

**Aufrufen:** Im Chat `lies .roorules_helper/workflows/<name>.md und führe ihn durch`
oder in einer Rule referenzieren.

---

## Skills / Slash-Commands

Roo Code hat keine dedizierten `/skill`-Slash-Commands wie Cline.
Wiederholbare Prompt-Templates gehören direkt in die zugehörige Rule-Datei
als **"Aufrufen mit:"**-Abschnitt, oder als Workflow.
