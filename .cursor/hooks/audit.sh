#!/bin/bash
# Audit agent actions for tracking and compliance

set -euo pipefail

# Read input from stdin
INPUT=$(cat)

# Create audit log directory if it doesn't exist
AUDIT_DIR="${HOME}/.cursor/audit"
mkdir -p "$AUDIT_DIR"

# Generate timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Get hook event name
EVENT_NAME=$(echo "$INPUT" | jq -r '.hook_event_name // "unknown"')

# Log to audit file
AUDIT_FILE="${AUDIT_DIR}/agent-audit.log"
echo "[$TIMESTAMP] $EVENT_NAME" >> "$AUDIT_FILE"
echo "$INPUT" | jq '.' >> "$AUDIT_FILE"
echo "---" >> "$AUDIT_FILE"

# Rotate log if it gets too large (keep last 1000 lines)
if [ -f "$AUDIT_FILE" ]; then
  LINE_COUNT=$(wc -l < "$AUDIT_FILE")
  if [ "$LINE_COUNT" -gt 1000 ]; then
    tail -n 1000 "$AUDIT_FILE" > "${AUDIT_FILE}.tmp"
    mv "${AUDIT_FILE}.tmp" "$AUDIT_FILE"
  fi
fi

exit 0

