#!/bin/bash
# Block dangerous git operations in React Native projects

set -euo pipefail

# Read input from stdin
INPUT=$(cat)

# Parse command from JSON input
COMMAND=$(echo "$INPUT" | jq -r '.command // empty')

# Exit if no command provided
if [ -z "$COMMAND" ]; then
  echo '{"permission": "allow"}'
  exit 0
fi

# Check for dangerous git operations
if [[ "$COMMAND" =~ ^git.*push.*--force ]]; then
  # Check if pushing to main/master
  if [[ "$COMMAND" =~ (main|master) ]] || git branch --show-current | grep -qE '^(main|master)$' 2>/dev/null; then
    echo '{
      "permission": "deny",
      "userMessage": "Force push to main/master is blocked for safety",
      "agentMessage": "Cannot force push to main/master branch. This operation is blocked to prevent accidental data loss."
    }'
    exit 0
  fi
fi

# Block hard reset on main/master
if [[ "$COMMAND" =~ ^git.*reset.*--hard ]] && git branch --show-current | grep -qE '^(main|master)$' 2>/dev/null; then
  echo '{
    "permission": "deny",
    "userMessage": "Hard reset on main/master is blocked for safety",
    "agentMessage": "Cannot perform hard reset on main/master branch. This operation is blocked to prevent accidental data loss."
  }'
  exit 0
fi

# Block git commands that skip hooks (--no-verify, --no-gpg-sign)
if [[ "$COMMAND" =~ --no-verify ]] || [[ "$COMMAND" =~ --no-gpg-sign ]]; then
  echo '{
    "permission": "ask",
    "userMessage": "This git command skips hooks. Allow?",
    "agentMessage": "This command attempts to skip git hooks. User approval required."
  }'
  exit 0
fi

# Block removal of node_modules or .expo without confirmation
if [[ "$COMMAND" =~ rm.*-rf.*(node_modules|\.expo|ios/Pods) ]]; then
  echo '{
    "permission": "ask",
    "userMessage": "Remove React Native build artifacts?",
    "agentMessage": "Attempting to remove build artifacts. User approval required."
  }'
  exit 0
fi

# Allow by default
echo '{"permission": "allow"}'
exit 0

