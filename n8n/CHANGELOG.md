# Changelog

## [1.0.2] - 2026-03-04

### Added
- New `host` option: set a reverse-proxy domain (e.g. `n8n.lostuser.net`) to automatically configure `WEBHOOK_URL` and `N8N_EDITOR_BASE_URL` as `https://<host>/`
- Explicit `webhook_url` option still takes precedence over `host` when both are set

## [1.0.1] - 2026-03-03

### Fixed
- Set `N8N_SECURE_COOKIE=false` to allow access over HTTP (HA Ingress)

## [1.0.0] - 2026-03-03

### Added
- Initial release of the n8n Home Assistant add-on
- n8n installed from npm (latest stable)
- Persistent data storage in `/config/.n8n`
- SQLite database by default (data survives restarts and updates)
- Auto-generated, persisted encryption key for stored credentials
- Optional basic auth for the n8n UI
- Optional external webhook URL configuration
- Home Assistant Ingress support (UI embedded in add-on page)
- Exposed port 5678 for direct LAN access
