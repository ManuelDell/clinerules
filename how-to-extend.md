# Clinerules erweitern — Rules, Hooks, Workflows, Skills

Dieses Repository ist darauf ausgelegt einfach erweiterbar zu sein.
Hier steht wie du jeden Typ hinzufügst.

---

## Rule erstellen

**Wann:** Du willst Cline dauerhaft auf ein Thema / eine Technologie hinweisen.

**Datei:** `.clinerules/<name>.md` (Unterordner möglich)

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
| Situation                  | Datei          |
|----------------------------|----------------|
| Mein neues Thema           | `mein-thema.md`|
```

Cline lädt alle `.md`-Dateien in `.clinerules/` automatisch — kein weiterer Setup nötig.

---

## Hook erstellen

**Wann:** Du willst automatisch auf ein Tool-Event reagieren (blockieren, Context anreichern, loggen).

**Datei:** `.clinerules/hooks/<event-name>` — **kein** `.sh`-Suffix, ausführbar machen:
```bash
chmod +x .clinerules/hooks/<event-name>
```

**Verfügbare Events:**
| Event           | Wann                              | Kann blockieren? |
|-----------------|-----------------------------------|------------------|
| `task-start`    | Beim Start jeder Cline-Session    | Nein (nur Context) |
| `pre-tool-use`  | Vor jedem Tool-Aufruf             | Ja               |
| `post-tool-use` | Nach jedem Tool-Aufruf            | Nein             |
| `task-complete` | Am Ende einer Cline-Session       | Nein             |

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

# Deine Logik hier:
# if [[ "$TOOL" == "..." && "$FILE" == *"..."* ]]; then
#   echo '{"cancel": true, "errorMessage": "..."}'
#   exit 0
# fi

echo '{"cancel": false}'
```

---

## Workflow erstellen

**Wann:** Du willst einen Prozess mit mehreren Schritten dokumentieren (Checkliste, Befehlsabfolge).

**Datei:** `.clinerules/workflows/<name>.md`

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

**Aufrufen:** Im Chat `lies workflows/<name>.md und führe ihn durch` oder in einer Rule referenzieren:
```markdown
## Lies `workflows/<name>.md` für <Situation>
```

---

## Skill erstellen

**Wann:** Du willst einen Slash-Befehl der Cline eine komplexe, wiederholbare Aktion ausführen lässt.

**Datei:** `.clinerules/skills/<name>.md`

**Aufruf im Chat:** `/name` (Cline erkennt den Dateinamen als Befehl)

**Format:**
```markdown
# Skill: <Name>

## Zweck
Was dieser Skill macht — in einem Satz.

## Ausführung
Wenn dieser Skill aufgerufen wird, soll Cline:
1. Schritt 1 (konkret, nicht vage)
2. Schritt 2
3. ...

## Ausgabeformat
Wie soll die Ausgabe aussehen? (Optional)

## Parameter
Falls der Skill Argumente nimmt: `/name <argument>`
- `<argument>`: Was erwartet wird
```

**Wichtig:** Skills enthalten kein Shell-Code — sie sind Prompt-Templates für Cline.
Shell-Code gehört in Hooks. Prozess-Dokumentation gehört in Workflows.
