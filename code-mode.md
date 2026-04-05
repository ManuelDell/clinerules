# Code Mode — Implementieren, Verifizieren, Committen

Dieser Modus verwendet **Qwen3-Coder** (Coding-Modell via OpenRouter).
Plan muss vor Implementierung klar sein — unklar? → Architect-Modus zuerst.

---

## Wann Code-Modus

- Implementierungsplan liegt vor (aus Architect-Modus oder klarer Anforderung)
- Routine-Änderungen: Bugfix, kleine Feature, Refactor
- Terminal-Operationen: Tests, Build, Linter, Deploy

---

## Coding-Prinzipien

### Diff-First — nie Full-Rewrite
```
❌ write_to_file mit kompletter Datei neu schreiben
✅ edit_file / apply_diff für gezielte Änderungen
```
Roo sendet nur die Diff-Lines ans Modell → weniger Tokens, weniger Fehlerrisiko.
Full-Rewrite nur wenn: neue Datei, oder >80% der Datei ändert sich.

### Read Before Write
Jede Datei die geändert wird zuerst vollständig lesen.
Kein Schreiben aus dem Gedächtnis.

### Kleinste funktionierende Einheit
Erst minimal implementieren, dann erweitern wenn nötig.
Keine spekulativen Features, kein Boilerplate.

---

## Verify-Loop — nach jeder Änderung

```bash
# Nach Code-Änderung immer mindestens eines davon:
python -m pytest        # Python Tests
npm test                # JS/TS Tests  
docker compose build    # Build verifizieren
pylint / eslint         # Linter
```

**Grün = fertig. Rot = Self-Correction Loop starten** (→ `roo-workflow.md`)

Nie als "Done" markieren ohne grüne Validierung.

---

## Terminal-Autonomie

Bei Fehler:
1. Fehlermeldung lesen — vollständig, nicht nur die letzte Zeile
2. Ursache identifizieren
3. Fix durchführen
4. Erneut validieren
5. Erst nach 2 gescheiterten Versuchen eskalieren (→ Architect-Modus)

---

## Commit-Disziplin

Nach erfolgreicher Validierung:
```bash
git add <nur betroffene Dateien>
git commit -m "feat|fix|refactor: präzise Beschreibung (max 72 Zeichen)"
```

Commit-Message erklärt das **Warum**, nicht das Was.
Kein `git add -A` blind. Kein Commit mit fehlschlagenden Tests.

---

## Fortschritts-Check — kein stiller Abbruch

Zähle interne Tool-Runden mit. Nach **20 Runden** ohne messbaren Fortschritt
(gleiche Fehler wiederholen sich, kein neuer Dateistatus, zirkuläre Fixes): **STOPP.**

1. Erkläre dem User was versucht wurde
2. Benenne die Blockade klar (warum es nicht funktioniert)
3. Frage explizit: *"Soll ich mit einem anderen Ansatz weitermachen? [Ja/Nein + Hinweis]"*

Nie stumm weiterarbeiten wenn ein Plan offensichtlich nicht greift.

---

## Kontext-Verwaltung bei langen Aufgaben

Wenn der Kontext-Indikator von Roo **lang** wird — proaktiv handeln, nicht warten:

1. `~/.roo/memory/activeContext.md` updaten:
   - Aktuelle Aufgabe + Stand
   - Offene Dateien + relevante Änderungen
   - Nächster konkreter Schritt
2. `~/.roo/memory/progress.md` updaten: was ist erledigt, was kommt
3. Nach Context-Reset liest der Task-Start-Hook die Memory Bank automatisch → kein Kontext-Verlust

**Nie auf den Kontext-Reset warten — proaktiv sichern bevor der Kontext voll ist.**

---

## Modell-Mapping

Code-Modus → `code-auto` via OpenRouter-Stack (Router-Klasse: `professional`)
Fallback-Kette: Qwen3-Coder:free → Llama-3.3-70B:free → DeepSeek-V3.2
Alle Modelle tool-fähig. Token-effizient durch Diff-Editing.
