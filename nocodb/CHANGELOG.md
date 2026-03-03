# Changelog

## [1.0.0] - 2026-03-03

### Added
- Initial release of the NocoDB Home Assistant add-on
- NocoDB installed from npm (latest stable)
- Persistent data storage in `/config/.nocodb`
- SQLite database by default (data survives restarts and updates)
- Auto-generated, persisted JWT secret for authentication
- Optional external database URL (PostgreSQL, MySQL)
- Optional public URL configuration for correct link generation
- Home Assistant Ingress support (UI embedded in add-on page)
- Exposed port 8080 for direct LAN access
