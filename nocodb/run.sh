#!/usr/bin/env bash
set -euo pipefail

# Ensure pnpm global binaries are in PATH
export PNPM_HOME="/root/.local/share/pnpm"
export PATH="${PNPM_HOME}:$(npm config get prefix)/bin:${PATH}"

OPTIONS_FILE="/data/options.json"

if [ ! -f "$OPTIONS_FILE" ]; then
  echo "ERROR: Missing $OPTIONS_FILE (add-on options)."
  exit 1
fi

# ------------------------------------------------------------------------------
# Read add-on options
# ------------------------------------------------------------------------------

TZNAME=$(jq -r '.timezone // "Europe/Sofia"' "$OPTIONS_FILE")
NC_PORT=$(jq -r '.port // 8080' "$OPTIONS_FILE")
NC_DB=$(jq -r '.database_url // ""' "$OPTIONS_FILE")
JWT_SECRET=$(jq -r '.jwt_secret // ""' "$OPTIONS_FILE")
PUBLIC_URL=$(jq -r '.public_url // ""' "$OPTIONS_FILE")

export TZ="$TZNAME"

# ------------------------------------------------------------------------------
# Persistent data directory (/addon_config/<slug> mapped to /config)
# ------------------------------------------------------------------------------
NC_DATA_DIR="/config/.nocodb"
mkdir -p "$NC_DATA_DIR"

# ------------------------------------------------------------------------------
# Set NocoDB environment variables
# ------------------------------------------------------------------------------
export PORT="$NC_PORT"

# Database: use external URL or fall back to local SQLite
if [ -n "$NC_DB" ]; then
  export NC_DB="$NC_DB"
else
  # SQLite stored in persistent data dir
  export NC_DB="sqlite3:///$NC_DATA_DIR/noco.db?synchronous=NORMAL&journal_mode=WAL"
fi

# JWT secret for NocoDB Auth
if [ -n "$JWT_SECRET" ]; then
  export NC_AUTH_JWT_SECRET="$JWT_SECRET"
else
  # Auto-generate and persist a JWT secret
  SECRET_FILE="$NC_DATA_DIR/.jwt_secret"
  if [ ! -f "$SECRET_FILE" ]; then
    echo "Generating NocoDB JWT secret..."
    head -c 48 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 48 > "$SECRET_FILE"
    chmod 600 "$SECRET_FILE"
  fi
  export NC_AUTH_JWT_SECRET="$(cat "$SECRET_FILE")"
fi

# Public URL (optional)
if [ -n "$PUBLIC_URL" ]; then
  export NC_PUBLIC_URL="$PUBLIC_URL"
fi

# Tool directory for NocoDB to store uploads/plugins
export NC_TOOL_DIR="$NC_DATA_DIR"

# Disable telemetry
export NC_DISABLE_TELE="true"

echo "Starting NocoDB on port ${NC_PORT}..."
echo "Data directory: ${NC_DATA_DIR}"

exec nocodb
