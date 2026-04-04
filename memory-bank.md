# Memory Bank — Persistenter Kontext über Sessions

Die Memory Bank ist ein globales Arbeitsgedächtnis unter `~/.roo/memory/`.
Sie überlebt Context-Resets, Roo-Neustarts und Modell-Wechsel.

---

## Dateien

```
~/.roo/memory/
├── projectBrief.md     Was ist das Projekt? Tech-Stack, Ziele, Constraints
├── activeContext.md    Womit wird gerade gearbeitet? Offene Entscheidungen?
├── progress.md         Was ist erledigt? Was kommt als nächstes?
└── systemPatterns.md   Wiederkehrende Architektur-Patterns und Entscheidungen
```

### projectBrief.md
Ändert sich selten. Enthält:
- Projektname und Zweck (1-2 Sätze)
- Tech-Stack (Sprachen, Frameworks, Tools)
- Kern-Constraints (Performance, Sicherheit, Kompatibilität)

### activeContext.md
Ändert sich häufig — nach jedem bedeutenden Task. Enthält:
- Aktueller Fokus: "Gerade an X"
- Offene Fragen / Entscheidungen
- Bekannte Probleme und deren Status

### progress.md
Task-Log. Enthält:
- Abgeschlossene Tasks (kurz, mit Datum)
- Nächste Schritte
- Bekannte Baustellen

### systemPatterns.md
Architektur-Wissen. Enthält:
- Entscheidungen und deren Begründung
- Wiederkehrende Patterns ("Immer X wenn Y")
- Anti-Patterns ("Nie Z machen weil...")

---

## Wann lesen

Der `task-start` Hook liest `activeContext.md` und `progress.md` automatisch
und injiziert sie als Kontext. Kein manuelles Lesen nötig beim Session-Start.

Bei komplexen Tasks zusätzlich lesen:
```bash
cat ~/.roo/memory/projectBrief.md
cat ~/.roo/memory/systemPatterns.md
```

---

## Wann updaten

| Situation | Datei updaten |
|---|---|
| Task abgeschlossen | `activeContext.md`, `progress.md` |
| Neue Architektur-Entscheidung | `systemPatterns.md`, `activeContext.md` |
| Projektstart oder Scope-Änderung | `projectBrief.md` |
| Blockiert / Offene Frage | `activeContext.md` |

Update-Format für `activeContext.md`:
```markdown
# Active Context

## Aktueller Fokus
[Was gerade bearbeitet wird]

## Offene Entscheidungen
- [Frage 1]
- [Frage 2]

## Bekannte Probleme
- [Problem und Status]

_Zuletzt aktualisiert: [Datum]_
```

---

## Setup

`setup.sh` legt die Dateien beim ersten Mal an.
Bei bereits vorhandenen Dateien nichts überschreiben.

```bash
bash .roorules_helper/setup.sh
```
