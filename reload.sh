#!/bin/bash

# Reload better-plan-mode plugin
# This script uninstalls and reinstalls the plugin from the local marketplace

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MARKETPLACE_NAME="paulcedrick"
PLUGIN_NAME="better-plan-mode"

echo "=== Reloading $PLUGIN_NAME ==="
echo ""

# Uninstall existing plugin
echo "Uninstalling existing plugin..."
claude plugin uninstall "$PLUGIN_NAME@$MARKETPLACE_NAME" 2>/dev/null || echo "  (not currently installed)"
echo ""

# Remove and re-add the marketplace to refresh
echo "Refreshing marketplace..."
claude plugin marketplace remove "$MARKETPLACE_NAME" 2>/dev/null || true
claude plugin marketplace add "$SCRIPT_DIR"
echo ""

# Install the plugin from the marketplace
echo "Installing plugin..."
claude plugin install "$PLUGIN_NAME@$MARKETPLACE_NAME"
echo ""

echo "=== Done! ==="
echo ""
echo "Restart Claude Code for changes to take effect."
