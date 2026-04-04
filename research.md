# Research Rule

## Wann recherchieren

Immer bevor Code für unbekannte Libraries, APIs oder Technologien geschrieben wird.
Immer wenn die beste Lösung nicht offensichtlich ist.
Nie: bei trivialen Änderungen die du sicher kennst.

## Reihenfolge

1. **Vorhandenes lesen** — existierenden Code und Konfiguration im Workspace verstehen
   - Was ist schon implementiert?
   - Welche Muster werden bereits genutzt?
   - Gibt es ähnliche Stellen die als Vorlage dienen?

2. **Offizielle Dokumentation** — Primärquelle, nicht Tutorials oder StackOverflow
   - Versionsnummern beachten — Lösungen für alte Versionen sind oft falsch
   - Breaking Changes in Changelogs prüfen

3. **Spezifische Fehler / Randfälle** — gezielt suchen was schiefgehen kann
   - "Known issues" und GitHub Issues der Library
   - Bekannte Inkompatibilitäten

## Qualität einer guten Recherche

- Mindestens 2 unabhängige Quellen für kritische Entscheidungen
- Datum/Version der Quelle beachten — veraltete Lösungen sind häufig
- Unterscheiden: "funktioniert" vs. "ist Best Practice"

## Ergebnis festhalten

Relevante Erkenntnisse direkt in `plans/<name>.md` unter **Kontext** oder **Entscheidungen** eintragen.
Keine separate Recherche-Datei — Wissen landet im Plan.

## Was Recherche NICHT ist

- Blind googeln und erste Lösung kopieren
- Tutorial-Code übernehmen ohne zu verstehen warum
- AI-generierte Antworten als Wahrheit nehmen ohne zu prüfen
