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

Lies die zugehörige Regel **vor** dem Arbeiten:

| Situation | Datei |
|---|---|
| Neues Projekt / neue Phase | `planning.md` |
| Recherche nötig | `research.md` |
| Python schreiben | `python.md` |
| JavaScript / TypeScript schreiben | `javascript.md` |
| CSS schreiben | `css.md` |
| Docker / Compose | `docker.md` |
| Frappe / ERPNext | `frappe.md` |
| API-Calls implementieren | `api.md` |
| Shell-Befehle ausführen | `bash.md` |
| Git-Operationen | `git.md` |

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
