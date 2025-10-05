#!/bin/bash
# Format edited files with Prettier for React Native/TypeScript projects

set -euo pipefail

# Read input from stdin
INPUT=$(cat)

# Parse the file path from JSON input
FILE_PATH=$(echo "$INPUT" | jq -r '.file_path // empty')

# Exit if no file path provided
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only format TypeScript, JavaScript, JSON, and Markdown files
if [[ "$FILE_PATH" =~ \.(ts|tsx|js|jsx|json|md)$ ]]; then
  # Check if file exists
  if [ -f "$FILE_PATH" ]; then
    # Try to format with Prettier if available
    if command -v npx &> /dev/null; then
      npx prettier --write "$FILE_PATH" 2>/dev/null || true
    fi

    # Try to lint TypeScript files with ESLint if available
    if [[ "$FILE_PATH" =~ \.(ts|tsx|js|jsx)$ ]] && command -v npx &> /dev/null; then
      npx eslint --fix "$FILE_PATH" 2>/dev/null || true
    fi
  fi
fi

exit 0

