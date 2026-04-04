# Frappe / ERPNext Rules

## Häufigste Fehler — Vermeide X, mache Y

**Bench-Befehle**
❌ Bench-Befehle als root ausführen
✅ Immer als den eingestellten frappe-User: `sudo -u <frappe-user> bench <cmd>` oder in der frappe-Shell

❌ `bench restart` vergessen nach Python-Änderungen
✅ Nach jeder `.py`-Änderung: `bench restart`

❌ Nach JS/CSS-Änderungen nur neu laden
✅ `bench build --app <appname>` dann Browser-Cache leeren (Ctrl+Shift+R)

**Custom Apps**
❌ Core-Frappe-Dateien direkt ändern — werden bei Updates überschrieben
✅ Custom App anlegen: `bench new-app <name>`, dann hooks/overrides nutzen

❌ Business-Logik direkt im Controller — ungetestet, schwer wartbar
✅ Logik in separate Python-Module, Controller ruft sie auf

**DocTypes**
❌ Datenbankzugriff mit raw SQL ohne frappe.db
✅ `frappe.db.get_value()`, `frappe.db.sql()` mit Parametern (kein f-string in SQL!)

❌ `frappe.db.sql(f"SELECT * WHERE name = '{name}'")`  — SQL Injection
✅ `frappe.db.sql("SELECT * WHERE name = %s", (name,))`

❌ Direkt `frappe.db.commit()` in Controllern
✅ Frappe managed Transactions — kein manuelles commit außer in Scripts

**Permissions**
❌ `frappe.get_doc()` ohne Permissions-Check
✅ `frappe.get_doc()` respektiert Permissions automatisch; `frappe.get_doc(ignore_permissions=True)` nur wo explizit nötig und kommentiert

## Typischer Entwicklungs-Workflow

```bash
cd frappe-bench
bench --site <site> console          # Python REPL mit Frappe-Kontext
bench --site <site> migrate          # Schema-Änderungen anwenden
bench --site <site> clear-cache      # Cache leeren
bench build --app <app>              # JS/CSS neu bauen
bench restart                        # Worker + Server neu starten
```

## Logs

```bash
tail -f logs/frappe.log              # App-Logs
tail -f logs/worker.error.log        # Background Jobs
bench --site <site> scheduler-events # Geplante Jobs
```
