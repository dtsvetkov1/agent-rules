#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

GITHUB_USER="dtsvetkov1"
GITHUB_REPO="agent-rules"
GITHUB_BRANCH="main"
REPO_URL="https://raw.githubusercontent.com/${GITHUB_USER}/${GITHUB_REPO}/${GITHUB_BRANCH}"
API_URL="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/contents"

echo -e "${BLUE}🤖 React Native Expo AI Agent Rules Setup${NC}"
echo -e "${BLUE}========================================${NC}\n"

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠️  Warning: Not in a git repository root. Make sure you're in your project root directory.${NC}"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check if jq is available for JSON parsing
if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}⚠️  jq not found. Using grep instead${NC}"
    USE_JQ=false
else
    USE_JQ=true
fi

# Function to download file
download_file() {
    local url=$1
    local dest=$2

    echo -e "${BLUE}📥 Downloading: ${dest}${NC}"

    if command -v curl &> /dev/null; then
        curl -fsSL "$url" -o "$dest" || {
            echo -e "${RED}❌ Failed to download $dest${NC}"
            return 1
        }
    elif command -v wget &> /dev/null; then
        wget -q "$url" -O "$dest" || {
            echo -e "${RED}❌ Failed to download $dest${NC}"
            return 1
        }
    else
        echo -e "${RED}❌ Neither curl nor wget found. Please install one of them.${NC}"
        exit 1
    fi
}

# Function to get list of files from GitHub directory
get_github_files() {
    local path=$1
    local api_url="${API_URL}/${path}?ref=${GITHUB_BRANCH}"

    if command -v curl &> /dev/null; then
        response=$(curl -fsSL "$api_url")
    elif command -v wget &> /dev/null; then
        response=$(wget -qO- "$api_url")
    fi

    # Parse JSON response to get file names
    if [ "$USE_JQ" = true ]; then
        echo "$response" | jq -r '.[] | select(.type=="file") | .name'
    else
        # Fallback: simple grep-based parsing
        echo "$response" | grep -o '"name":"[^"]*"' | grep -o ':[^:]*$' | tr -d ':"'
    fi
}

# Create directories
echo -e "${BLUE}📁 Creating directories...${NC}"
mkdir -p .cursor/commands
mkdir -p .cursor/rules
mkdir -p .cursor/hooks

# Download AGENTS.md
download_file "$REPO_URL/AGENTS.md" "AGENTS.md"

# Download .cursor/rules files
echo -e "\n${BLUE}📋 Fetching Cursor rules...${NC}"
rules_files=$(get_github_files ".cursor/rules")
if [ -n "$rules_files" ]; then
    while IFS= read -r file; do
        [ -z "$file" ] && continue
        download_file "$REPO_URL/.cursor/rules/$file" ".cursor/rules/$file"
    done <<< "$rules_files"
else
    echo -e "${RED}❌ Failed to fetch commands list${NC}"s
fi

# Download .cursor/commands files
echo -e "\n${BLUE}⚡ Fetching command templates...${NC}"
commands_files=$(get_github_files ".cursor/commands")
if [ -n "$commands_files" ]; then
    while IFS= read -r file; do
        [ -z "$file" ] && continue
        download_file "$REPO_URL/.cursor/commands/$file" ".cursor/commands/$file"
    done <<< "$commands_files"
else
    echo -e "${RED}❌ Failed to fetch commands list${NC}"
    exit 1
fi

# Download hooks.json
echo -e "\n${BLUE}🔗 Fetching hooks configuration...${NC}"
download_file "$REPO_URL/.cursor/hooks.json" ".cursor/hooks.json"

# Download hooks documentation
download_file "$REPO_URL/.cursor/HOOKS.md" ".cursor/HOOKS.md"

# Download .cursor/hooks scripts
echo -e "\n${BLUE}🪝 Fetching hook scripts...${NC}"
hooks_files=$(get_github_files ".cursor/hooks")
if [ -n "$hooks_files" ]; then
    while IFS= read -r file; do
        [ -z "$file" ] && continue
        download_file "$REPO_URL/.cursor/hooks/$file" ".cursor/hooks/$file"
        # Make hook scripts executable
        if [[ "$file" == *.sh ]]; then
            chmod +x ".cursor/hooks/$file"
            echo -e "${GREEN}  ✓ Made $file executable${NC}"
        fi
    done <<< "$hooks_files"
else
    echo -e "${YELLOW}⚠️  No hooks found or failed to fetch hooks${NC}"
fi

echo -e "\n${GREEN}✅ Setup complete!${NC}\n"
echo -e "${GREEN}The following files have been added to your project:${NC}"
echo -e "  ${GREEN}•${NC} AGENTS.md - Main AI coding guidelines"
echo -e "  ${GREEN}•${NC} .cursor/rules/ - Cursor-specific AI rules"
echo -e "  ${GREEN}•${NC} .cursor/commands/ - Helpful command templates"
echo -e "  ${GREEN}•${NC} .cursor/hooks.json - Hook configuration"
echo -e "  ${GREEN}•${NC} .cursor/hooks/ - AI agent lifecycle hooks"

echo -e "\n${YELLOW}📝 Next steps:${NC}"
echo -e "  1. ${RED}Restart Cursor${NC} to activate hooks"
echo -e "  2. Review AGENTS.md and customize for your project"
echo -e "  3. Check .cursor/HOOKS.md for hook documentation"
echo -e "  4. Verify hooks in Cursor Settings > Hooks tab"
echo -e "  5. Commit these files to your repository"
echo -e "  6. Share with your team!"

echo -e "\n${BLUE}🪝 Installed Hooks:${NC}"
echo -e "  ${GREEN}•${NC} format.sh - Auto-format edited files"
echo -e "  ${GREEN}•${NC} audit.sh - Log agent actions to ~/.cursor/audit/"
echo -e "  ${GREEN}•${NC} block-dangerous-git.sh - Prevent force pushes to main"
echo -e "  ${GREEN}•${NC} redact-secrets.sh - Block reading of .env files"
echo -e "  ${GREEN}•${NC} check-secrets.sh - Scan prompts for API keys"

echo -e "\n${BLUE}💡 Tip: These rules and hooks work with Cursor AI to guide and protect code generation${NC}"
