# JavaScript / TypeScript Rules

## Häufigste Fehler — Vermeide X, mache Y

**Variablen**
❌ `var x = 1` — function-scoped, Hoisting-Falle
✅ `const` als Default; `let` nur wenn Reassignment nötig

**Vergleiche**
❌ `x == null` — prüft auch `undefined` ungewollt
✅ `x === null` für exakt null; `x == null` nur wenn null+undefined zusammen gewollt

**Async**
❌ `.then().then().catch()` Chains — schwer lesbar, Fehler gehen verloren
✅ `async/await` mit `try/catch`
❌ `async function f() { doSomething() }` — fehlendes `await`
✅ Jeder async Call muss `await` haben oder explizit `.catch()` bekommen

**Fehlerbehandlung**
❌ `promise.then(fn)` ohne `.catch()` — unhandled rejection
✅ `await promise` in try/catch ODER `.catch(handler)` immer anhängen

**Arrays**
❌ `for (const key in array)` — iteriert über Prototype-Properties
✅ `for (const item of array)` oder `.forEach()` / `.map()`

**Null-Safety**
❌ `user.address.city` — crash wenn address undefined
✅ `user?.address?.city ?? "unbekannt"`

**State (React/Vue)**
❌ `state.items.push(item)` — direktes Mutieren
✅ `setState([...state.items, item])` — immer neues Objekt/Array

**TypeScript**
❌ `as any` als Problemlösung
✅ korrekten Typ definieren oder `unknown` mit Type Guard

## Prinzipien

- **Immutability bevorzugen** — `const`, spread, `Object.freeze()`
- **Kein Code nach `return`** — toter Code erzeugt keine Warnung in JS
- **Event Listener aufräumen** — `removeEventListener` / Cleanup in `useEffect` return
- **Fehler nie schlucken** — `catch (e) {}` verboten; mindestens loggen
- **Kein `console.log` in Commits** — nur für temporäres Debugging

## Module

- Named exports bevorzugen über default exports (besser refactorbar)
- Zirkuläre Imports vermeiden — auf Struktur hinweist das Modul zu groß ist
