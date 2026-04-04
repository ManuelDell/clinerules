# Planning Rule

## Wann dieser Prozess greift

Immer wenn:
- Ein neues Projekt beginnt
- Eine neue Projektphase beginnt
- Die Aufgabe > 3 Schritte umfasst
- Technologieentscheidungen getroffen werden müssen

## Ablageort für Plan-Dateien

Plan-Dateien gehören in `<workspace-root>/plans/` — **NICHT** in `.clinerules/plans/`.

`.clinerules/` ist ein gemeinsames Git-Repo (shared rules). Cline schreibt dort **nie** rein.
Pläne sind workspace-spezifisch und gehören in das Projekt-Verzeichnis.

```
workspace-root/
├── .clinerules/        ← shared git repo — NUR LESEN, nie beschreiben
│   ├── rules.md
│   └── ...
├── plans/              ← Cline schreibt hier
│   └── feature-name.md
└── src/
```

`plans/` in `.gitignore` eintragen wenn Pläne nicht versioniert werden sollen.
Oder bewusst committen wenn die Planung zum Projekt gehört — beides ist valide.

---

## Pflicht-Ablauf

### 1. Recherche
Lies `research.md` und führe sie durch.
Ziel: verstehen was existiert, was benötigt wird, was schiefgehen kann.

### 2. Plan formulieren

Lege an: `plans/<projektname>.md`
Inhalt der Datei:

```markdown
# Plan: <Projektname>

## Stand
Phase: <aktuell> | Status: <Entwurf / In Arbeit / Abgeschlossen>
Letzte Änderung: <Datum>

## Kontext
Warum wird das gemacht? Was ist der Auslöser?

## Ziel
Was soll am Ende funktionieren? (konkret, testbar)

## Ansatz
Welche Technologie / Architektur / Methode und warum.

## Schritte
- [ ] Schritt 1
- [ ] Schritt 2
- [ ] ...

## Risiken & offene Fragen
- ...

## Entscheidungen
Getroffene Entscheidungen mit Begründung festhalten.
```

### 3. Plan vorlegen

Zeige dem Nutzer:
```
Plan erstellt: plans/<projektname>.md

Kurzzusammenfassung:
- Ziel: ...
- Ansatz: ...
- Schritte: N Schritte

Bitte bestätigen oder Änderungen mitteilen.
```

**Warte auf explizite Bestätigung. Schreibe keinen Code vorher.**

### 4. Ausführung

- Schritte der Reihe nach abarbeiten
- Jeden Schritt in `plans/<projektname>.md` als `[x]` markieren wenn fertig
- Bei unerwarteten Erkenntnissen: Plan aktualisieren und kurz kommunizieren

### 5. Abschluss

Plan-Datei finalisieren:
- Alle Schritte abgehakt
- `Status: Abgeschlossen` setzen
- Getroffene Entscheidungen dokumentieren

## Regelwerk für Plan-Dateien

- **Eine Datei pro Projekt**, nicht pro Sitzung
- Bei neuer Phase: bestehende Datei erweitern (neuer Abschnitt), nicht neu anlegen
- Bei grundlegender Richtungsänderung: alten Plan als `## Phase X (abgeschlossen)` archivieren, neuen Plan darunter
- Dateiname: lowercase, kebab-case → `plans/user-auth.md`, `plans/api-refactor.md`
