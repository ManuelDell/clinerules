# General Rule — Cline

## Umgebung zuerst prüfen

**Bevor irgendwas getan wird:**
1. `pwd` — in welchem Verzeichnis bin ich?
2. Vorhandene Dateien, Config, existierenden Code lesen
3. Welche Tools/Laufzeiten sind installiert? (`python --version`, `node --version`, etc.)
4. Gibt es eine `plans/`-Datei für dieses Projekt?

Nie annehmen — immer prüfen. Unbekannte Umgebung → kurz fragen.

---

## Verhalten: Erstanfrage vs. Weiterführende Anfrage

**Erstanfrage / Neues Projekt / Neue Projektphase:**
Erkennbar an: kein `plans/<name>.md` vorhanden, neue Aufgabe ohne vorherigen Kontext.
→ Pflicht-Ablauf: **Recherche → Plan → Vorlage → Warten auf Bestätigung → Ausführung**
→ Lies `planning.md` und führe den Prozess vollständig durch.

**Weiterführende Anfrage:**
Erkennbar an: Plan-Datei existiert, Aufgabe knüpft an vorherigen Kontext an.
→ `plans/<name>.md` öffnen, aktuellen Stand erfassen, Anfrage direkt bearbeiten.
→ Plan nach Abschluss aktualisieren.

---

## Rückfragen

Stelle bis zu 3 gezielte Rückfragen wenn Anforderungen unklar sind — **bevor du Code schreibst**.
Formuliere Optionen als nummerierte Auswahl:
```
Welchen Ansatz bevorzugst du?
1. Variante A (schneller, weniger flexibel)
2. Variante B (aufwändiger, erweiterbar)
```
**Triff so wenig Annahmen wie möglich.** Unklare Anforderungen führen zu falschem Code.

---

## Pflicht-Referenzen

Alle Regeldetails liegen in `.clinerules_helper/`. Lies die zugehörige Datei **vor** dem Arbeiten:

| Situation | Datei |
|---|---|
| Neues Projekt / neue Phase | `.clinerules_helper/planning.md` |
| Recherche nötig | `.clinerules_helper/research.md` |
| Python schreiben | `.clinerules_helper/python.md` |
| JavaScript / TypeScript schreiben | `.clinerules_helper/javascript.md` |
| CSS schreiben | `.clinerules_helper/css.md` |
| Docker / Compose | `.clinerules_helper/docker.md` |
| Frappe / ERPNext | `.clinerules_helper/frappe.md` |
| API-Calls implementieren | `.clinerules_helper/api.md` |
| Shell-Befehle ausführen | `.clinerules_helper/bash.md` |
| Git-Operationen | `.clinerules_helper/git.md` |
| Große Projekte / Token-Effizienz | `.clinerules_helper/large-projects.md` |
| Unbekannte Codebasis verstehen | `.clinerules_helper/workflows/understand-codebase.md` |
| Sichere Änderung in großem Projekt | `.clinerules_helper/workflows/safe-change.md` |
| Rule / Hook / Workflow / Skill erstellen | `.clinerules_helper/how-to-extend.md` |

**`.clinerules/` ist read-only.** Cline schreibt nie in diese Verzeichnisse.
**Alle Cline-Arbeitsdateien** (Pläne etc.) → `.cline/` im Workspace-Root (gitignored, ein Ordner für alles).

Hooks die automatisch greifen:
- `hooks/task-start` — prüft Umgebung und injiziert Kontext beim Taskstart
- `hooks/pre-tool-use` — blockiert kritische Dateien vor Überschreiben

---

## Universelle Coding-Regeln

**Kein Code zweimal.** Logik existiert einmal — referenzieren statt kopieren.
**Keine Annahmen über Umgebung.** Immer prüfen was tatsächlich vorhanden ist.
**Kleinste funktionierende Einheit.** Erst minimal, dann erweitern wenn nötig.
**Kein Code ohne Zweck.** Kein Boilerplate, keine spekulativen Features, kein "könnte später nützlich sein".
**Fehler sofort sichtbar machen.** Lieber crash mit klarer Meldung als stilles Fehlverhalten.
**Änderungen lesen bevor schreiben.** Jede Datei die geändert wird zuerst vollständig lesen.
