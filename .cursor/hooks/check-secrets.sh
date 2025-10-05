#!/bin/bash
# Check for secrets in prompts before submitting to AI

set -euo pipefail

# Read input from stdin
INPUT=$(cat)

# Parse prompt and attachments from JSON input
PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty')
ATTACHMENTS=$(echo "$INPUT" | jq -r '.attachments // [] | .[] | .file_path // empty' | tr '\n' ' ')

# Check for potential secrets in prompt text
SECRET_PATTERNS=(
  'sk-[a-zA-Z0-9]{48}'           # OpenAI API keys
  'AIza[0-9A-Za-z-_]{35}'        # Google API keys
  'AKIA[0-9A-Z]{16}'             # AWS access key
  '[0-9]{12}:[a-f0-9]{40}'       # Firebase keys
  'xox[baprs]-[0-9a-zA-Z]{10,48}' # Slack tokens
  'ghp_[a-zA-Z0-9]{36}'          # GitHub tokens
  'sk_live_[a-zA-Z0-9]{24}'      # Stripe keys
  'Bearer [a-zA-Z0-9_\-\.]{20,}'  # Bearer tokens
  'password["\']?\s*[:=]\s*["\'][^"\']{8,}' # Password assignments
)

for pattern in "${SECRET_PATTERNS[@]}"; do
  if echo "$PROMPT" | grep -qiE "$pattern"; then
    echo '{
      "continue": false
    }'
    exit 0
  fi
done

# Check attachments for sensitive files
if [ -n "$ATTACHMENTS" ]; then
  for file in $ATTACHMENTS; do
    if [[ "$file" =~ \.(env|pem|key|p12|keystore|jks)$ ]]; then
      echo '{
        "continue": false
      }'
      exit 0
    fi
  done
fi

# Allow by default
echo '{"continue": true}'
exit 0
