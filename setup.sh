#!/bin/bash
# setup.sh — Erstellt .roorules/ im Workspace aus diesem Helper-Repo
#
# Aufruf (aus dem Workspace-Root):
#   bash .roorules_helper/setup.sh
#
# Ergebnis:
#   .roorules/rules.md               ← thin rules, referenziert .roorules_helper/
#   .roorules/hooks/                 ← task-start, pre-tool-use (ausführbar)
#   .roorules-architect/             ← mode-spezifische Rules für Architect-Modus
#   .roorules-code/                  ← mode-spezifische Rules für Code-Modus
#   ~/.roo/memory/                   ← globale Memory Bank (einmalig, falls nicht vorhanden)

set -e

HELPER_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE="$(cd "$HELPER_DIR/.." && pwd)"
ROORULES="$WORKSPACE/.roorules"
ROORULES_ARCH="$WORKSPACE/.roorules-architect"
ROORULES_CODE="$WORKSPACE/.roorules-code"
MEMORY_DIR="$HOME/.roo/memory"

echo "Helper:    $HELPER_DIR"
echo "Workspace: $WORKSPACE"
echo ""

# ── .roorules/ ───────────────────────────────────────────────────────────────
mkdir -p "$ROORULES/hooks"

cp "$HELPER_DIR/rules.md" "$ROORULES/rules.md"
echo "  ✓ .roorules/rules.md"

for hook in task-start pre-tool-use; do
    if [[ -f "$HELPER_DIR/hooks/$hook" ]]; then
        cp "$HELPER_DIR/hooks/$hook" "$ROORULES/hooks/$hook"
        chmod +x "$ROORULES/hooks/$hook"
        echo "  ✓ .roorules/hooks/$hook"
    fi
done

# ── .roorules-architect/ ─────────────────────────────────────────────────────
mkdir -p "$ROORULES_ARCH"
cp "$HELPER_DIR/architect-mode.md" "$ROORULES_ARCH/architect-mode.md"
echo "  ✓ .roorules-architect/architect-mode.md"

# ── .roorules-code/ ──────────────────────────────────────────────────────────
mkdir -p "$ROORULES_CODE"
cp "$HELPER_DIR/code-mode.md" "$ROORULES_CODE/code-mode.md"
echo "  ✓ .roorules-code/code-mode.md"

# ── ~/.roo/memory/ (global, einmalig) ────────────────────────────────────────
mkdir -p "$MEMORY_DIR"

for file in projectBrief activeContext progress systemPatterns; do
    TARGET="$MEMORY_DIR/${file}.md"
    if [[ ! -f "$TARGET" ]]; then
        cp "$HELPER_DIR/memory-templates/${file}.md" "$TARGET" 2>/dev/null || \
        echo "# ${file}" > "$TARGET"
        echo "  ✓ ~/.roo/memory/${file}.md (neu angelegt)"
    else
        echo "  ~ ~/.roo/memory/${file}.md (bereits vorhanden, unverändert)"
    fi
done

echo ""
echo "Fertig. Roo liest beim nächsten Start nur .roorules/rules.md."
echo "Domain-Rules in .roorules_helper/ werden on-demand gelesen."
echo "Memory Bank: ~/.roo/memory/"
