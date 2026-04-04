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

## Modell-Mapping

Code-Modus → `qwen/qwen3-coder-next` via OpenRouter-Stack (Router-Klasse: TITAN_PAID)
Token-effizient durch Diff-Editing. Stark bei Code-Generation und Tool-Calls.
