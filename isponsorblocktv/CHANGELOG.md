# Changelog

## [1.0.0] - 2026-06-08

### Added
- Initial iSponsorBlockTV Home Assistant app.
- Wraps the official `ghcr.io/dmunozv04/isponsorblocktv:latest` container.
- Generates upstream `config.json` from Home Assistant app options.
- Persists generated configuration under `/config/isponsorblocktv`.
- Enables host networking for YouTube TV device discovery and communication.
