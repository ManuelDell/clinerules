# roo rules — Roo Code Rules, Hooks & Workflows

Allgemeine Roo Code Konfiguration für alle Workspaces.
**Migration von Cline zu Roo Code** — diff-basiertes Editing, Custom Modes, Memory Bank.

---

## Warum Roo statt Cline?

| Feature | Cline | Roo Code |
|---|---|---|
| **Editing** | Full-File-Rewrite (viele Tokens) | Diff-only (nur geänderte Zeilen) |
| **Modi** | Ein Modus | Custom Modes (Architect, Code) |
| **Token-Kosten** | Hoch bei großen Dateien | Massiv reduziert |
| **Mode-Rules** | Eine `.clinerules/` für alles | `.roorules-architect/`, `.roorules-code/` |
| **Memory** | Kein Persistenz-Mechanismus | Memory Bank via Hook-Injektion |

**Was Roo zusätzlich ermöglicht:**
- **Architect-Modus (DeepSeek-R1):** Plant, entscheidet, delegiert — kein Code schreiben
- **Code-Modus (Qwen3-Coder):** Implementiert mit Diff-Editing, verifiziert, committet
- **Boomerang-Pattern:** Architect plant → Code führt aus → Architect reviewt
- **Memory Bank (`~/.roo/memory/`):** Kontext überlebt Context-Resets und Session-Neustarts
- **Self-Correction Loop:** Terminal-Fehler werden autonom behoben, nie ignoriert

---

## Setup (einmalig pro Workspace)

```bash
cd /pfad/zum/workspace
git clone https://github.com/ManuelDell/clinerules.git .roorules_helper
bash .roorules_helper/setup.sh
```

Erstellt:
- `.roorules/rules.md` + `hooks/` — von Roo automatisch geladen
- `.roorules-architect/architect-mode.md` — nur im Architect-Modus
- `.roorules-code/code-mode.md` — nur im Code-Modus
- `~/.roo/memory/` — globale Memory Bank (einmalig, falls nicht vorhanden)

### Updates

```bash
cd .roorules_helper && git pull
bash setup.sh
```

---

## VS Code Konfiguration

Roo Code Extension installieren: **`roo-cline.roo-cline`** (VS Code Marketplace)

Danach in `.vscode/settings.json` oder User Settings:

```json
{
  "roo-cline.apiProvider": "openai-compatible",
  "roo-cline.openAiBaseUrl": "http://localhost:8085/v1",
  "roo-cline.openAiApiKey": "openrouter-via-proxy",
  "roo-cline.customModes": [
    {
      "slug": "architect",
      "name": "🏗️ Architect",
      "model": "deepseek/deepseek-r1",
      "roleDefinition": "Du bist ein Software-Architekt. Du planst, entscheidest und delegierst. Du schreibst keinen Code — nur strukturierte Pläne mit nummerierten Schritten. Lies .roorules_helper/architect-mode.md.",
      "groups": ["read"]
    },
    {
      "slug": "code",
      "name": "⚡ Code",
      "model": "qwen/qwen3-coder-next",
      "roleDefinition": "Du implementierst. Diff-first: nutze edit_file statt write_to_file. Verifiziere nach jeder Änderung. Behebe Terminal-Fehler autonom. Lies .roorules_helper/code-mode.md.",
      "groups": ["read", "edit", "command", "mcp"]
    }
  ]
}
```

**Voraussetzung:** OpenRouter AI Stack läuft lokal auf Port 8085.
MCP-Server (Tools: `web_search`, `search_memory`, `screenshot`) auf Port 8087.

---

## Zwei-Ordner-Prinzip

Roo lädt alle `.md`-Dateien in `.roorules/` automatisch — das kostet Context-Tokens.

| Ordner | Inhalt | Wie geladen |
|---|---|---|
| `.roorules/` | `rules.md` + `hooks/` | Immer automatisch |
| `.roorules-architect/` | Architect-spezifische Rules | Nur im Architect-Modus |
| `.roorules-code/` | Code-spezifische Rules | Nur im Code-Modus |
| `.roorules_helper/` | Alle Domain-Rules, Workflows | On-demand (Roo liest wenn nötig) |

---

## Hooks

Ausführbare Shell-Skripte, automatisch von Roo ausgeführt:

| Hook | Event | Funktion |
|---|---|---|
| `task-start` | Session-Start | Memory Bank injizieren, Stack-Status prüfen |
| `pre-tool-use` | Vor jedem Tool-Call | `.env` vor Überschreiben schützen |

Hooks kommunizieren per JSON (stdin/stdout):
- `{"cancel": false}` → durchlassen
- `{"cancel": true, "errorMessage": "..."}` → blockieren
- `{"contextModification": "..."}` → Text in Context injizieren

---

## Rule / Hook / Workflow erstellen

→ Lies `.roorules_helper/how-to-extend.md`
