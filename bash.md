# Bash / Terminal Rule

## Häufigste Fehler — Vermeide X, mache Y

**Sicherheit**
❌ `rm -rf $DIR` ohne vorherige Prüfung ob `$DIR` leer/undefined ist
✅ `[[ -n "$DIR" ]] && rm -rf "$DIR"`

❌ User-Input direkt in Befehlen: `eval "$user_input"`
✅ Input validieren, nie direkt ausführen

❌ `chmod 777` als schneller Fix
✅ Minimale Rechte: Owner braucht was? → `chmod 750`

**Variablen**
❌ `if [ $var == "value" ]` — bricht wenn var leer
✅ `if [[ "$var" == "value" ]]` — immer quoten, `[[` statt `[`

❌ Variablen ohne Anführungszeichen in Pfaden: `cp $file $dest`
✅ `cp "$file" "$dest"` — Leerzeichen in Pfaden brechen sonst

**Fehlerbehandlung**
❌ Fehler ignorieren und weitermachen
✅ Script mit `set -euo pipefail` beginnen:
  - `-e` — bei Fehler abbrechen
  - `-u` — ungesetzte Variablen als Fehler
  - `-o pipefail` — Pipe-Fehler weitergeben

**Ausgabe**
❌ Output in Schleife parsen: `for line in $(cat file)`
✅ `while IFS= read -r line; do ...; done < file`

## Vor jedem Befehl

1. **Was macht dieser Befehl genau?** — Bei Unklarheit zuerst `--dry-run` oder `echo` nutzen
2. **Ist er reversibel?** — Destructive Operations (rm, dd, truncate) extra prüfen
3. **Läuft er im richtigen Verzeichnis?** — `pwd` prüfen, `cd` mit absoluten Pfaden

## Debugging

```bash
bash -n script.sh          # Syntax prüfen ohne Ausführen
bash -x script.sh          # Jeden Befehl vor Ausführung ausgeben
set -x                     # Ab dieser Zeile tracing
set +x                     # Tracing beenden
```

## Umgebung prüfen bevor Befehle ausgeführt werden

```bash
command -v docker          # Prüfen ob Tool installiert
[[ -f .env ]] && source .env   # Datei nur laden wenn vorhanden
echo "Working in: $(pwd)"      # Kontext bestätigen
```
