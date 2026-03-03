# OpenClaw – Home Assistant Add-ons Repository

## [Join our Discord Server!](https://discord.gg/Nx4H3XmY)
![OpenClaw Assistant](https://github.com/techartdev/OpenClawHomeAssistant/blob/main/oca_addon.png?raw=true)

This repository contains Home Assistant add-ons for **Home Assistant OS (HAOS)**.

## Available Add-ons

### OpenClaw Assistant
> Upstream rename history (FYI): clawdbot → moltbot → **openclaw** (final).

Run **OpenClaw** inside Home Assistant.

- **AI Gateway** — OpenClaw server with chat, skills, and automation capabilities
- **Web Terminal** — browser-based terminal embedded in Home Assistant
- **Assist Pipeline** — use OpenClaw as a conversation agent via the OpenAI-compatible API
- **Browser Automation** — Chromium included for web scraping and automation skills
- **Persistent Storage** — skills, config, and workspace survive add-on updates
- **Bundled Tools** — git, vim, nano, bat, fd, ripgrep, curl, jq, python3, pnpm, Homebrew

### n8n
Powerful workflow automation tool. Connect anything to everything — trigger automations, integrate services, and build workflows with a visual editor. Data and credentials persist across restarts.

- Visual workflow editor accessible via Home Assistant Ingress
- SQLite by default; optional external DB support
- Webhook endpoint support

### NocoDB
Open Source Airtable Alternative. Turn any database into a smart collaborative spreadsheet with a rich web UI.

- Full NocoDB UI accessible via Home Assistant Ingress
- SQLite by default; supports PostgreSQL and MySQL
- REST & GraphQL API included

## Supported Architectures

| Architecture | Supported |
|---|---|
| amd64 | ✅ |
| aarch64 (RPi 4/5) | ✅ |
| armv7 (RPi 3) | ✅ |

## Documentation

- **[Full documentation →](DOCS.md)** — installation, configuration, use cases, troubleshooting, and more
- **[Security Risks & Disclaimer →](SECURITY.md)** — important risks to understand before using this add-on

## Install

1. Home Assistant → **Settings → Add-ons → Add-on store**
2. **⋮ → Repositories**
3. Add this repo:
   - `https://github.com/techartdev/OpenClawHomeAssistant`
4. Install any add-on from the list: **OpenClaw Assistant**, **n8n**, or **NocoDB**

## Support / Donations

If you find this useful and you want to bring me a coffee to make more useful things, or support the project, use the link below:
- https://revolut.me/vanyo6dhw
