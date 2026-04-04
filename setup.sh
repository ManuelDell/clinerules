#!/bin/bash
# setup.sh — Erstellt .clinerules/ im Workspace aus diesem Helper-Repo
#
# Aufruf (aus dem Workspace-Root):
#   bash .clinerules_helper/setup.sh
#
# Ergebnis:
#   .clinerules/rules.md      ← thin rules, referenziert .clinerules_helper/
#   .clinerules/hooks/        ← task-start, pre-tool-use (ausführbar)

set -e

HELPER_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE="$(cd "$HELPER_DIR/.." && pwd)"
CLINERULES="$WORKSPACE/.clinerules"

echo "Helper: $HELPER_DIR"
echo "Workspace: $WORKSPACE"
echo "Ziel: $CLINERULES"
echo ""

# .clinerules/ anlegen
mkdir -p "$CLINERULES/hooks"

# Thin rules.md kopieren
cp "$HELPER_DIR/rules.md" "$CLINERULES/rules.md"
echo "  ✓ rules.md"

# Hooks kopieren + ausführbar machen
for hook in task-start pre-tool-use; do
    if [[ -f "$HELPER_DIR/hooks/$hook" ]]; then
        cp "$HELPER_DIR/hooks/$hook" "$CLINERULES/hooks/$hook"
        chmod +x "$CLINERULES/hooks/$hook"
        echo "  ✓ hooks/$hook"
    fi
done

echo ""
echo "Fertig. Cline liest beim nächsten Start nur .clinerules/rules.md."
echo "Alle Domain-Rules liegen in .clinerules_helper/ und werden on-demand gelesen."
