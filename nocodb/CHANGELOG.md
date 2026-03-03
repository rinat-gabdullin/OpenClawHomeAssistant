# Changelog

## [1.0.3] - 2026-03-03

### Fixed
- Set `PNPM_HOME` explicitly in Dockerfile so pnpm global bin directory is available during build and at runtime

## [1.0.2] - 2026-03-03

### Fixed
- Install NocoDB via pnpm (resolves build error caused by `only-allow pnpm` preinstall check in `nocodb-sdk`)
- Add pnpm global bin directory to PATH in run.sh

## [1.0.1] - 2026-03-03

### Fixed
- Add npm global bin directory to PATH so `nocodb` binary is found at runtime

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
