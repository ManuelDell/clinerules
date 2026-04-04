# clinerules — Cline Rules, Hooks & Workflows

Allgemeine Cline-Konfiguration für alle Workspaces.
Dieses Repo wird als `.clinerules_helper/` geklont — nur `rules.md` und `hooks/`
werden per `setup.sh` nach `.clinerules/` kopiert, damit Cline nicht alle Dateien
automatisch lädt.

## Setup (einmalig pro Workspace)

```bash
cd /pfad/zum/workspace
git clone https://github.com/ManuelDell/clinerules.git .clinerules_helper
bash .clinerules_helper/setup.sh
```

Das war es. Cline liest beim nächsten Start nur `.clinerules/rules.md`.
Alle Domain-Rules in `.clinerules_helper/` werden on-demand gelesen.

### Updates

```bash
cd .clinerules_helper && git pull
bash setup.sh   # hooks + rules.md neu kopieren
```

---

## Warum zwei Ordner?

Cline lädt **alle** `.md`-Dateien in `.clinerules/` automatisch bei jeder Session.
Das kostet Context-Tokens, auch wenn die Regel gerade irrelevant ist.

| Ordner | Inhalt | Wie geladen |
|---|---|---|
| `.clinerules/` | `rules.md` + `hooks/` | Immer automatisch |
| `.clinerules_helper/` | Alle Domain-Rules, Workflows | On-demand (Cline liest sie wenn nötig) |

---

## Was ist was?

| Typ | Wo | Wann aktiv | Wofür |
|---|---|---|---|
| **Rules** | `*.md` | On-demand über `rules.md` | Sprachen, Tools, Workflows |
| **Hooks** | `hooks/` | Bei bestimmten Events | Automatik, Schutzmechanismen |

### Hooks

Ausführbare Shell-Skripte. Cline führt sie bei definierten Events aus:

| Hook | Event |
|---|---|
| `task-start` | Neuer Task beginnt — Umgebung prüfen, Context anreichern |
| `pre-tool-use` | Vor jedem Tool-Aufruf — kritische Dateien schützen |

Hooks kommunizieren per JSON (stdin/stdout):
- `{"cancel": false}` → durchlassen
- `{"cancel": true, "errorMessage": "..."}` → blockieren
- `{"contextModification": "..."}` → Text in Context injizieren

### Neue Rule / Hook / Workflow / Skill erstellen

→ Lies `.clinerules_helper/how-to-extend.md`
