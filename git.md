# Git Rule

## Häufigste Fehler — Vermeide X, mache Y

**Commits**
❌ `git add .` — staged versehentlich Secrets, Build-Artefakte, .env
✅ `git add <spezifische-dateien>` — explizit was committed wird

❌ Commit-Message: `"fix"`, `"update"`, `"changes"`
✅ Conventional Commits: `feat: add user auth`, `fix: null pointer in login`, `docs: update README`

❌ Riesige Commits mit 20 Dateien
✅ Atomare Commits — eine logische Änderung pro Commit

**Branches**
❌ Direkt auf `main`/`master` entwickeln
✅ Feature-Branch: `git checkout -b feat/user-auth`

❌ `git push --force` auf geteilten Branches
✅ `git push --force-with-lease` wenn rebase nötig — schützt vor überschreiben fremder Änderungen

**Gefahrliche Operationen**
❌ `git reset --hard` ohne vorherigen `git status`
✅ Immer `git status` + `git log --oneline -5` vor destructiven Operationen

❌ `git clean -fd` ohne `-n` dry-run
✅ Erst `git clean -nfd` (zeigt was gelöscht würde), dann `git clean -fd`

## Authentifizierung mit Token (HTTPS)

**Token niemals in Remote-URL speichern:**
❌ `git remote set-url origin https://TOKEN@github.com/user/repo.git`
— Token landet in `.git/config`, in Shell-History, in Logs

✅ Credential Helper nutzen:
```bash
git config --global credential.helper store    # einmalig
# Beim nächsten Push: User + Token einmal eingeben → wird gespeichert
```

✅ Oder: SSH-Key statt HTTPS — kein Token-Management nötig:
```bash
ssh-keygen -t ed25519 -C "email"
# Public Key → GitHub Settings → SSH Keys
git remote set-url origin git@github.com:user/repo.git
```

✅ Für einmalige Operationen (CI/CD, Scripts):
```bash
# Token aus Env-Var, nicht hardcoded
git clone https://${GITHUB_TOKEN}@github.com/user/repo.git
```

**`.gitignore` Pflicht-Einträge:**
```
.env
*.env.local
*.key
*.pem
__pycache__/
node_modules/
.DS_Store
```

## Workflow

```bash
git status                          # Immer zuerst
git diff --staged                   # Was wird committed?
git log --oneline -10               # Kontext verstehen
git stash                           # Änderungen temporär parken
git stash pop                       # Zurückholen
```

## Commit-Message Format

```
<typ>: <kurze Beschreibung> (max 72 Zeichen)

[optionaler Body — warum, nicht was]

Typen: feat | fix | docs | style | refactor | test | chore
```
