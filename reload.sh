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

MARKETPLACE_NAME="paulcedrick"

echo "Adding local marketplace..."
claude plugin marketplace add "$SCRIPT_DIR" 2>/dev/null || echo "  (marketplace already added)"

echo "Updating marketplace..."
claude plugin marketplace update "$MARKETPLACE_NAME"

echo "Installing $PLUGIN_NAME..."
claude plugin install "$PLUGIN_NAME"

echo ""
echo "=== Done! ==="
echo ""
echo "Restart Claude Code for changes to take effect."
