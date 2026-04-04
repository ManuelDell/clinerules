# Roo Agentic Workflow

Kernregeln für autonomes Arbeiten mit Roo Code. Gilt für alle Modi.

---

## ReAct-Loop — Thought → Action → Observation

Vor **jeder nicht-trivialen Aktion** explizit denken:

```
Thought: Was ist das Ziel? Was könnte schiefgehen? Welcher Ansatz ist minimal?
Action:  Tool-Call ausführen
Observe: Ergebnis lesen — was hat sich verändert? Was ist unerwartet?
→ Nächster Thought basierend auf Observation
```

Kein Blind-Handeln. Kein "ich mache mal". Kein Überspringen von Observations.

---

## Self-Correction Loop — Fehler autonom beheben

Bei Terminal-Fehler (Linter, Test, Build, Syntax):

1. Fehlermeldung vollständig lesen
2. Root Cause identifizieren — nicht symptomatisch fixen
3. Fix durchführen
4. Validierung wiederholen
5. Erst wenn Validierung **grün** → Task als erledigt markieren

**Nie:** "Fehler ignoriert, Task trotzdem abgeschlossen."
**Nie:** Beim ersten Fehler eskalieren ohne Analyse.
**Immer:** Mindestens 2 Korrekturversuche bevor Nutzer gefragt wird.

---

## Mode-Wechsel-Regel

| Situation | Modus |
|---|---|
| Aufgabe unklar, Architektur-Entscheidung nötig, mehrere Ansätze denkbar | **Architect** |
| Plan ist klar, Implementierung läuft | **Code** |
| Blockiert nach 2 Versuchen, fundamentales Design-Problem | → zurück zu **Architect** |

Nicht im Code-Modus planen. Nicht im Architect-Modus Code schreiben.

---

## Memory Bank — Pflicht nach bedeutenden Tasks

Nach jedem abgeschlossenen Task der etwas verändert:

```bash
# Was aktualisieren:
~/.roo/memory/activeContext.md   # Womit wird gerade gearbeitet? Offene Entscheidungen?
~/.roo/memory/progress.md        # Was wurde erledigt? Was kommt als nächstes?
```

Wann nötig (mind. eines davon):
- Neue Datei/Modul erstellt
- Architektur-Entscheidung getroffen
- Bug behoben der Verständnis des Systems verändert hat
- Task-Phase abgeschlossen

`projectBrief.md` und `systemPatterns.md` nur bei fundamentalen Änderungen updaten.

---

## Git-Disziplin

Nach erfolgreicher Validierung (Tests grün, Linter sauber):

```bash
git add <betroffene Dateien>   # nie git add -A blind
git commit -m "typ: kurze präzise Beschreibung"
```

Commit-Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`
Kein Commit ohne grüne Validierung.
