#!/usr/bin/env bash
set -euo pipefail

OPTIONS_FILE="/data/options.json"
DATA_DIR="/config/isponsorblocktv"
CONFIG_FILE="${DATA_DIR}/config.json"

if [ ! -f "$OPTIONS_FILE" ]; then
  echo "ERROR: Missing $OPTIONS_FILE (app options)."
  exit 1
fi

mkdir -p "$DATA_DIR"

TZNAME=$(jq -r '.timezone // "Europe/Sofia"' "$OPTIONS_FILE")
export TZ="$TZNAME"

CONFIGURED_DEVICES=$(jq '(.devices // []) | map(select((.screen_id // "") != "")) | length' "$OPTIONS_FILE")
if [ "$CONFIGURED_DEVICES" -eq 0 ]; then
  echo "ERROR: No YouTube TV devices configured."
  echo "Add at least one device with a screen_id in the iSponsorBlockTV app configuration."
  exit 1
fi

jq '{
  devices: (
    (.devices // [])
    | map(select((.screen_id // "") != ""))
    | map({
        screen_id: .screen_id,
        name: (.name // "YouTube on TV"),
        offset: (.offset // 0)
      })
  ),
  skip_categories: (.skip_categories // ["sponsor"]),
  skip_count_tracking: (.skip_count_tracking // true),
  mute_ads: (.mute_ads // true),
  skip_ads: (.skip_ads // true),
  minimum_skip_length: (.minimum_skip_length // 1),
  auto_play: (.auto_play // true),
  join_name: (.join_name // "iSponsorBlockTV"),
  apikey: (.apikey // ""),
  channel_whitelist: (
    (.channel_whitelist // [])
    | map(select((.id // "") != ""))
    | map({
        id: .id,
        name: (.name // "")
      })
  ),
  use_proxy: (.use_proxy // false)
}' "$OPTIONS_FILE" > "${CONFIG_FILE}.tmp"

mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
chmod 600 "$CONFIG_FILE"

rm -rf /app/data
ln -s "$DATA_DIR" /app/data

export iSPBTV_docker="True"
export iSPBTV_data_dir="data"
export TERM="${TERM:-xterm-256color}"
export COLORTERM="${COLORTERM:-truecolor}"

echo "Starting iSponsorBlockTV..."
echo "Data directory: ${DATA_DIR}"
echo "Configured devices: ${CONFIGURED_DEVICES}"

cd /app
exec python3 -u main.pyc
