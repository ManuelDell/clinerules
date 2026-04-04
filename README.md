# clinerules — Cline Config für OpenRouter AI Stack

Dieses Repository enthält die Cline-Konfiguration für alle Workspaces die mit dem
[OpenRouter AI Stack](https://github.com/ManuelDell/openrouter-ai-stack) arbeiten.

## Setup (einmalig pro Workspace)

```bash
cd /pfad/zum/workspace
git clone https://github.com/ManuelDell/clinerules.git .clinerules
```

Cline liest `.clinerules/` beim Start automatisch — fertig.

Updates holen:

```bash
cd .clinerules && git pull
```

---

## Was ist was?

| Typ | Wo | Wann aktiv | Wofür |
|---|---|---|---|
| **Rules** | `rules.md` | Immer, jede Session | Stack-Kontext, Coding-Standards, Verhalten |
| **Workflows** | `workflows/*.md` | Immer (als Referenz) | Schritt-für-Schritt-Anleitungen für komplexe Tasks |
| **Hooks** | `hooks/` | Bei bestimmten Events | Automatische Aktionen, Schutzmechanismen |

### Rules
Markdown-Instruktionen die Cline bei **jeder Konversation** liest.
Enthalten dauerhaften Kontext: wo bin ich, wie arbeite ich hier, welche Regeln gelten immer.
→ Kompakt halten: alles hier kostet immer Context-Window.

### Workflows
Ebenfalls Markdown — aber als Schritt-für-Schritt-Anleitungen für wiederkehrende Tasks.
Cline liest sie als Referenz. Man tippt: *"Führe Workflow deploy-router aus"* und Cline
arbeitet die Schritte ab ohne nachzufragen.
→ Dürfen ausführlicher sein, da sie nur auf Anfrage aktiv genutzt werden.

### Hooks
Ausführbare Shell-Skripte in `hooks/`. Cline führt sie bei definierten Events aus:

| Hook | Event | Inhalt hier |
|---|---|---|
| `task-start` | Neuer Task beginnt | Prüft Stack-Status, injiziert aktuelle Info |
| `pre-tool-use` | Vor jedem Tool-Aufruf | Schützt `.env` vor versehentlichem Überschreiben |

Hooks kommunizieren per JSON:
- `cancel: true` → Operation blockieren
- `contextModification` → Text in den Context injizieren
- `errorMessage` → Fehlermeldung an Cline
