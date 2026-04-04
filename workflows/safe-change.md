# Workflow: Sichere Änderung in großem Projekt

Nutze diesen Workflow bevor du eine Funktion, Klasse oder Datei änderst die von anderen
Teilen des Projekts genutzt wird. Verhindert stille Regressions durch unbekannte Abhängigkeiten.

---

## Wann dieser Workflow greift

- Funktion/Klasse wird umbenannt oder Signatur ändert sich
- Datei wird verschoben oder gelöscht
- Interface / API-Vertrag ändert sich (Parameter, Rückgabewert, Ausnahmen)
- Du bist unsicher ob jemand anderes deinen Code nutzt

---

## Schritte

### 1. Definition finden

```bash
# Python
grep -rn "def funktionsname\|class Klassenname" --include="*.py" .

# TypeScript/JS
grep -rn "function funktionsname\|export function\|export class" --include="*.ts" .

# Ergebnis: Datei:Zeile — nur diese Datei lesen
```

### 2. Alle Nutzer finden (Dependency Map)

```bash
# Direkte Aufrufe:
grep -rn "funktionsname(" .

# Imports:
grep -rn "from modul import\|import { Func }" .
grep -rn "require('./modul')" .

# Vererbung / Implementierung:
grep -rn "extends Klasse\|implements Interface" .
```

**Notiere:** N Stellen in M Dateien. Das ist dein Scope.

### 3. Kleinste Änderungseinheit bestimmen

Frage: Was ist das Minimum das geändert werden muss?

- Signature-Change? → Prüfe ob Default-Parameter reichen (backwards-compatible)
- Rename? → Prüfe ob Alias möglich (alten Namen behalten, neuen hinzufügen)
- Delete? → Prüfe ob wirklich 0 Nutzer

Ziel: Änderung die so klein wie möglich ist und so wenig wie möglich bricht.

### 4. Änderung durchführen

- Zuerst die Definition ändern
- Dann die Nutzer der Reihe nach anpassen
- Eine Datei auf einmal — nicht alle gleichzeitig

### 5. Ripple-Effekte verifizieren

```bash
# Gibt es noch alte Referenzen?
grep -rn "alter_funktionsname(" .
grep -rn "from alter_modul import" .

# Gibt es Type-Errors (TypeScript)?
npx tsc --noEmit 2>&1 | head -30

# Gibt es Import-Fehler (Python)?
python3 -c "import modul" 2>&1

# Tests laufen durch?
pytest tests/ -x -q 2>&1 | tail -20      # Python
npm test -- --passWithNoTests 2>&1 | tail -20  # Node
```

### 6. Checkpoint

Nach der Änderung — kurze Notiz in Plan-Datei:
```
## Änderung: login() → authenticate()
- Geändert: services/auth.py:42
- Angepasst: 3 Aufrufer (routes/api.py, tests/test_auth.py, middleware/session.py)
- Verifiziert: grep zeigt 0 verbleibende Referenzen auf "login("
```

---

## Schnell-Checkliste

```
[ ] Definition gefunden (Datei:Zeile)
[ ] Alle Nutzer gelistet (N Stellen, M Dateien)
[ ] Kleinste Änderungseinheit bestimmt
[ ] Definition geändert
[ ] Alle Nutzer angepasst
[ ] Grep: 0 alte Referenzen
[ ] Syntax/Type-Check grün
[ ] Tests grün (oder Fehler bewusst akzeptiert)
```
