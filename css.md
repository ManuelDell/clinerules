# CSS Rules

## Häufigste Fehler — Vermeide X, mache Y

**Spezifität**
❌ `!important` als Fix für Spezifitätsprobleme
✅ Selector-Spezifität reduzieren: flachere Selektoren schreiben
❌ `#id .parent .child span.class` — 4+ Ebenen
✅ BEM oder direkte Klassen: `.card__title`

**Einheiten**
❌ `font-size: 14px` — skaliert nicht mit Browser-Einstellungen
✅ `font-size: 0.875rem` — relativ zur Root-Font-Size
❌ `width: 320px` — bricht auf anderen Screens
✅ `max-width: 20rem` + `width: 100%`

**Layout**
❌ `position: absolute/fixed` für alles was nicht wirklich überlagert
✅ Flexbox für einachsige Layouts, Grid für zweiachsige
❌ `float` für Layouts
✅ `display: flex` oder `display: grid`

**Farben & Werte**
❌ `color: #3a7bd5` an 12 verschiedenen Stellen
✅ `--color-primary: #3a7bd5` als CSS-Variable, dann `color: var(--color-primary)`
❌ Magic Numbers: `margin-top: 23px`
✅ Aus dem Spacing-System: `margin-top: var(--space-md)`

**Inline-Styles**
❌ `style="color: red; font-weight: bold"`
✅ Klasse definieren — außer der Wert ist wirklich dynamisch (JS-berechnet)

**Box-Model**
❌ Kein `box-sizing` gesetzt — Padding ändert Breite unerwartet
✅ Global: `*, *::before, *::after { box-sizing: border-box }`

## Prinzipien

- **CSS-Variablen für alle wiederholten Werte** — Farben, Abstände, Radien, Breakpoints
- **Mobile First** — `min-width` Media Queries statt `max-width`
- **Kaskade nutzen** — Vererbung ist kein Bug, sondern Feature
- **Keine Duplikate** — gleiches Property zweimal im gleichen Selector ist ein Fehler
- **Selektoren beschreiben was etwas IST, nicht wie es aussieht** — `.btn-primary` ✅ `.big-blue-button` ❌

## Reihenfolge in Declarations (Konsistenz)

1. Positioning (`position`, `top`, `z-index`)
2. Box Model (`display`, `width`, `margin`, `padding`)
3. Typografie (`font-*`, `line-height`, `color`)
4. Visuals (`background`, `border`, `shadow`)
5. Animationen (`transition`, `animation`)
