#!/bin/bash

# Reload better-primitives plugin
# Usage: ./reload.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_NAME="better-primitives"

echo "=== Reloading $PLUGIN_NAME plugin ==="
echo ""

echo "Uninstalling $PLUGIN_NAME..."
claude plugin uninstall "$PLUGIN_NAME" 2>/dev/null || echo "  (not currently installed)"

echo "Installing $PLUGIN_NAME from $SCRIPT_DIR..."
claude plugin install "$SCRIPT_DIR"

echo ""
echo "=== Done! ==="
echo ""
echo "Restart Claude Code for changes to take effect."
