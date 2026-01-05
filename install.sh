#!/bin/bash

# Better Primitives - Claude Code Plugin Installer
# https://github.com/paulcedrick/better-primitives

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PLUGIN_NAME="better-primitives"
GITHUB_REPO="paulcedrick/better-primitives"

echo -e "${BLUE}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       Better Primitives - Plugin Installer         ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if claude CLI is installed
if ! command -v claude &> /dev/null; then
    echo -e "${RED}Error: Claude Code CLI is not installed.${NC}"
    echo ""
    echo "Please install Claude Code first:"
    echo "  npm install -g @anthropic-ai/claude-code"
    echo ""
    echo "Or visit: https://claude.ai/claude-code"
    exit 1
fi

echo -e "${GREEN}✓${NC} Claude Code CLI detected"

# Check Claude Code version (optional, for compatibility)
CLAUDE_VERSION=$(claude --version 2>/dev/null || echo "unknown")
echo -e "${BLUE}ℹ${NC} Claude Code version: ${CLAUDE_VERSION}"
echo ""

# Install the plugin
echo -e "${YELLOW}Installing ${PLUGIN_NAME} plugin...${NC}"
echo ""

if claude plugin install "${GITHUB_REPO}"; then
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║         Installation Successful!                   ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BLUE}Available commands:${NC}"
    echo ""
    echo "  /better-primitives:plan     - Enhanced planning with thorough questioning"
    echo "  /better-primitives:debug    - Thorough debugging with confidence-scored investigation"
    echo "  /better-primitives:analyze  - Thorough analysis for improvements"
    echo ""
    echo -e "${BLUE}Quick start:${NC}"
    echo ""
    echo "  claude"
    echo "  > /better-primitives:plan Add user authentication to my app"
    echo ""
    echo -e "${YELLOW}Tip:${NC} The skills also activate automatically when Claude detects"
    echo "     ambiguous requirements, bug reports, or improvement requests."
    echo ""
else
    echo ""
    echo -e "${RED}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║              Installation Failed                   ║${NC}"
    echo -e "${RED}╚════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Troubleshooting:"
    echo ""
    echo "  1. Check your internet connection"
    echo "  2. Ensure you have the latest Claude Code:"
    echo "     npm update -g @anthropic-ai/claude-code"
    echo "  3. Try installing manually:"
    echo "     git clone https://github.com/${GITHUB_REPO}.git"
    echo "     cd ${PLUGIN_NAME}"
    echo "     claude plugin install ."
    echo ""
    exit 1
fi
