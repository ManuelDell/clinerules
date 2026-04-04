# Large Projects & Token-Effizienz

## Grundprinzip

In großen Codebasen ist unkontrolliertes Lesen die Hauptursache für Context-Überlastung.
**Jede gelesene Datei kostet Tokens — lies nur was du brauchst.**

---

## Häufigste Fehler — Vermeide X, mache Y

**Navigation**

❌ Dateien blind öffnen ohne zu wissen ob sie relevant sind
✅ Erst `grep`/`glob` — Datei nur lesen wenn sie nachweislich relevant ist

❌ Verzeichnisstruktur durch rekursives `ls` erfassen
✅ Glob mit gezieltem Pattern: `**/*.py`, `src/**/*.ts`, `**/routes*`

❌ Gesamte Datei lesen um eine Funktion zu finden
✅ Grep nach Funktionsname → Zeile kennen → nur diesen Bereich lesen

**Änderungen**

❌ Funktion ändern ohne zu wissen wer sie nutzt
✅ Vor jeder Änderung: `grep -r "funktionsname"` → alle Nutzer kennen

❌ Mehrere Dateien gleichzeitig ändern ohne Plan
✅ Eine Änderung → Ripple-Effekte prüfen → nächste Änderung

❌ "Ich lese erst alle relevanten Dateien, dann schreibe ich"
✅ Gezielt lesen: nur die Datei die gerade geändert wird + direkte Abhängigkeiten

**Token-Haushalt**

❌ Dieselbe Datei mehrfach lesen weil man Details vergessen hat
✅ Wichtige Stellen notieren (Dateiname:Zeile) bevor man weitermacht

❌ Lange Fehlerausgaben vollständig im Context halten
✅ Nach Diagnose: relevante Zeile extrahieren, Rest verwerfen

---

## Dependency Mapping — Vor jeder Änderung

```bash
# Wer importiert diese Datei?
grep -r "from module import" --include="*.py" .
grep -r "import { Func }" --include="*.ts" .
grep -r "require('./module')" --include="*.js" .

# Wer ruft diese Funktion auf?
grep -rn "funktionsname(" .

# Welche Dateien hängen voneinander ab?
grep -rn "class ClassName" .   # Definition finden
grep -rn "ClassName" .         # Alle Nutzungen finden
```

**Prove Before Write:**
Bevor du eine Funktion/Klasse änderst — zeige dass du weißt:
1. Wo ist die Definition? (Datei:Zeile)
2. Wer nutzt sie? (N Stellen in M Dateien)
3. Was bricht wenn die Signatur sich ändert?

---

## Context Window Hygiene

**Wann ist der Context zu voll?**
- Cline-Warning erscheint ("context limit approaching")
- Antworten werden kürzer / unvollständiger
- Cline "vergisst" frühere Entscheidungen

**Was tun wenn Context voll:**

1. **Plan-Datei aktualisieren** — das ist der einzige State der Compact überlebt:
   - Offene Schritte mit aktuellem Stand
   - Getroffene Entscheidungen
   - Offene Fragen / Risiken
   - Wichtige Dateinamen und Zeilennummern

2. **`/compact`** ausführen (Cline-Befehl) — komprimiert den Gesprächsverlauf

3. **Nach Compact:**
   - Plan-Datei als erstes lesen
   - Gezielt Grep/Read für aktuell relevante Dateien
   - Nicht alle Dateien neu lesen — nur was der nächste Schritt braucht

**Faustregel:** Alle 30–50 Tool-Calls Plan-Datei aktualisieren — auch ohne Compact.

**Wichtig:** Hooks bekommen keine Token-Zählungen. Automatisches Compact-Triggern ist nicht möglich — der Nutzer oder Cline selbst muss es manuell auslösen.

---

## Token-sparende Such-Strategie

```
Aufgabe bekomme ich
        ↓
Grep: Gibt es schon Code der das tut?
        ↓
Glob: In welcher Datei würde das stehen?
        ↓
Grep in Datei: Welche Zeilen sind relevant?
        ↓
Read mit Offset+Limit: Nur den relevanten Bereich lesen
        ↓
Änderung durchführen
```

**Niemals:** Alle `.py`-Dateien öffnen "um einen Überblick zu bekommen".
**Immer:** Greppen, eingrenzen, dann gezielt lesen.

---

## Lies `workflows/understand-codebase.md` für unbekannte Codebasen
## Lies `workflows/safe-change.md` für Änderungen in großen Projekten
