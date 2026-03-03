# Changelog

## [1.0.7] - 2026-03-03

### Fixed
- Remove sqlite3:// URI from NC_DB — NocoDB fails to parse SQLite filenames with query parameters; SQLite DB is now created automatically by NocoDB in NC_TOOL_DIR

## [1.0.6] - 2026-03-03

### Changed
- Complete rewrite: use official `nocodb/nocodb:latest` Docker image instead of manual pnpm installation
- Entrypoint now calls `/usr/src/appEntry/start.sh` from the official image
- Removed all manual pnpm/npm install steps

## [1.0.5] - 2026-03-03

### Fixed
- Launcher wrapper now reads the correct entrypoint from `package.json` `main` field instead of hardcoding `src/index.js`

## [1.0.4] - 2026-03-03

### Fixed
- Allow pnpm build scripts globally (`allow-build=*`) so native modules (sqlite3, sharp, lz4) are compiled during build
- NocoDB has no registered bin entry — create `/usr/local/bin/nocodb` wrapper that calls `node .../nocodb/src/index.js`

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
