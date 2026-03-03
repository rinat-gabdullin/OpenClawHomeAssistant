#!/usr/bin/env bash
set -euo pipefail

OPTIONS_FILE="/data/options.json"

if [ ! -f "$OPTIONS_FILE" ]; then
  echo "ERROR: Missing $OPTIONS_FILE (add-on options)."
  exit 1
fi

# ------------------------------------------------------------------------------
# Read add-on options
# ------------------------------------------------------------------------------

TZNAME=$(jq -r '.timezone // "Europe/Sofia"' "$OPTIONS_FILE")
N8N_PORT=$(jq -r '.port // 5678' "$OPTIONS_FILE")
WEBHOOK_URL=$(jq -r '.webhook_url // ""' "$OPTIONS_FILE")
ENCRYPTION_KEY=$(jq -r '.encryption_key // ""' "$OPTIONS_FILE")
BASIC_AUTH_ACTIVE=$(jq -r '.basic_auth_active // false' "$OPTIONS_FILE")
BASIC_AUTH_USER=$(jq -r '.basic_auth_user // "admin"' "$OPTIONS_FILE")
BASIC_AUTH_PASSWORD=$(jq -r '.basic_auth_password // ""' "$OPTIONS_FILE")

export TZ="$TZNAME"

# ------------------------------------------------------------------------------
# Persistent data directory (/addon_config/<slug> mapped to /config)
# ------------------------------------------------------------------------------
N8N_DATA_DIR="/config/.n8n"
mkdir -p "$N8N_DATA_DIR"

# ------------------------------------------------------------------------------
# Set n8n environment variables
# ------------------------------------------------------------------------------
export N8N_USER_FOLDER="$N8N_DATA_DIR"
export N8N_PORT="$N8N_PORT"
export N8N_HOST="0.0.0.0"
export N8N_PROTOCOL="http"
export N8N_LISTEN_ADDRESS="0.0.0.0"

# Disable diagnostics / telemetry
export N8N_DIAGNOSTICS_ENABLED="false"
export N8N_VERSION_NOTIFICATIONS_ENABLED="false"

# Encryption key for stored credentials
if [ -n "$ENCRYPTION_KEY" ]; then
  export N8N_ENCRYPTION_KEY="$ENCRYPTION_KEY"
else
  # Auto-generate and persist a key so credentials survive restarts
  KEY_FILE="$N8N_DATA_DIR/.encryption_key"
  if [ ! -f "$KEY_FILE" ]; then
    echo "Generating n8n encryption key..."
    head -c 32 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 32 > "$KEY_FILE"
    chmod 600 "$KEY_FILE"
  fi
  export N8N_ENCRYPTION_KEY="$(cat "$KEY_FILE")"
fi

# Webhook URL (optional)
if [ -n "$WEBHOOK_URL" ]; then
  export WEBHOOK_URL="$WEBHOOK_URL"
fi

# Basic auth (optional)
if [ "$BASIC_AUTH_ACTIVE" = "true" ] && [ -n "$BASIC_AUTH_PASSWORD" ]; then
  export N8N_BASIC_AUTH_ACTIVE="true"
  export N8N_BASIC_AUTH_USER="$BASIC_AUTH_USER"
  export N8N_BASIC_AUTH_PASSWORD="$BASIC_AUTH_PASSWORD"
else
  export N8N_BASIC_AUTH_ACTIVE="false"
fi

# Use SQLite by default (stored in persistent data dir)
export DB_TYPE="sqlite"
export DB_SQLITE_DATABASE="$N8N_DATA_DIR/database.sqlite"

echo "Starting n8n on port ${N8N_PORT}..."
echo "Data directory: ${N8N_DATA_DIR}"

exec n8n start
