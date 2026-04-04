# General Rule — Roo Code

## Umgebung zuerst prüfen

**Bevor irgendwas getan wird:**
1. `pwd` — in welchem Verzeichnis bin ich?
2. Vorhandene Dateien, Config, existierenden Code lesen
3. Welche Tools/Laufzeiten sind installiert? (`python --version`, `node --version`, etc.)
4. Memory Bank lesen: `~/.roo/memory/activeContext.md` (wird automatisch via Hook injiziert)

Nie annehmen — immer prüfen. Unbekannte Umgebung → kurz fragen.

---

## Modus-Wahl (Architect vs. Code)

| Situation | Modus |
|---|---|
| Anforderung unklar, mehrere Ansätze möglich, Architektur-Frage | **Architect** |
| Plan steht, Implementierung läuft | **Code** |
| Blockiert nach 2 Versuchen | → **Architect** |

Details: `.roorules_helper/architect-mode.md` und `.roorules_helper/code-mode.md`

---

## Verhalten: Erstanfrage vs. Weiterführende Anfrage

**Erstanfrage / Neue Phase:**
Erkennbar an: kein Plan vorhanden, neue Aufgabe ohne vorherigen Kontext.
→ Pflicht-Ablauf: **Recherche → Plan → Vorlage → Bestätigung → Ausführung**
→ Lies `.roorules_helper/planning.md` für den vollständigen Prozess.

**Weiterführende Anfrage:**
Erkennbar an: Plan in `.roo/plans/` vorhanden, Aufgabe knüpft an bekannten Kontext an.
→ Memory Bank und Plan lesen, direkt weiterarbeiten.

---

## Rückfragen

Stelle bis zu 3 gezielte Rückfragen wenn Anforderungen unklar sind — **bevor du Code schreibst**.
Formuliere Optionen als nummerierte Auswahl:
```
Welchen Ansatz bevorzugst du?
1. Variante A (schneller, weniger flexibel)
2. Variante B (aufwändiger, erweiterbar)
```
**Triff so wenig Annahmen wie möglich.**

---

## Pflicht-Referenzen

Alle Regeldetails liegen in `.roorules_helper/`. Lies die zugehörige Datei **vor** dem Arbeiten:

| Situation | Datei |
|---|---|
| Agentic Workflow / ReAct / Self-Correction | `.roorules_helper/roo-workflow.md` |
| Memory Bank nutzen / updaten | `.roorules_helper/memory-bank.md` |
| Neues Projekt / neue Phase | `.roorules_helper/planning.md` |
| Recherche nötig | `.roorules_helper/research.md` |
| Python schreiben | `.roorules_helper/python.md` |
| JavaScript / TypeScript schreiben | `.roorules_helper/javascript.md` |
| CSS schreiben | `.roorules_helper/css.md` |
| Docker / Compose | `.roorules_helper/docker.md` |
| Frappe / ERPNext | `.roorules_helper/frappe.md` |
| API-Calls implementieren | `.roorules_helper/api.md` |
| Shell-Befehle ausführen | `.roorules_helper/bash.md` |
| Git-Operationen | `.roorules_helper/git.md` |
| Große Projekte / Token-Effizienz | `.roorules_helper/large-projects.md` |
| Unbekannte Codebasis verstehen | `.roorules_helper/workflows/understand-codebase.md` |
| Sichere Änderung in großem Projekt | `.roorules_helper/workflows/safe-change.md` |
| Rule / Hook / Workflow erstellen | `.roorules_helper/how-to-extend.md` |

**`.roorules/` ist read-only.** Roo schreibt nie in diese Verzeichnisse.
**Alle Roo-Arbeitsdateien** (Pläne etc.) → `.roo/` im Workspace-Root (gitignored).

Hooks die automatisch greifen:
- `hooks/task-start` — injiziert Memory Bank + Stack-Status beim Taskstart
- `hooks/pre-tool-use` — blockiert kritische Dateien vor Überschreiben

---

## Universelle Coding-Regeln

**Diff-first.** Gezielter Edit vor Full-Rewrite.
**Kein Code zweimal.** Logik existiert einmal — referenzieren statt kopieren.
**Keine Annahmen über Umgebung.** Immer prüfen was tatsächlich vorhanden ist.
**Kleinste funktionierende Einheit.** Erst minimal, dann erweitern wenn nötig.
**Fehler sofort sichtbar machen.** Lieber crash mit klarer Meldung als stilles Fehlverhalten.
**Änderungen lesen bevor schreiben.** Jede Datei die geändert wird zuerst vollständig lesen.
