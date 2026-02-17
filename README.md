<div align="center">

# 🏝️ Islands Dark for Antigravity

**A port of [Islands Dark](https://github.com/bwya77/vscode-dark-islands) to Google Antigravity IDE**

Deep backgrounds · Warm syntax highlighting · Glass-morphism UI · Smooth animations

![preview](https://raw.githubusercontent.com/bwya77/vscode-dark-islands/main/assets/CleanShot%202026-02-14%20at%2021.47.05%402x.png)

![preview2](https://raw.githubusercontent.com/bwya77/vscode-dark-islands/main/assets/CleanShot%202026-02-14%20at%2021.45.00%402x.png)

</div>

---

## What is this?

Antigravity is Google's AI-first IDE built on the VS Code engine. While it's compatible with VS Code themes, it uses **different file paths** for extensions and settings — so existing VS Code installers don't work out of the box.

This repo ports the beautiful Islands Dark theme + UI customizations to Antigravity with a fully automated installer.

---

## Features

- 🎨 **Islands Dark color theme** — deep `#131217` base with warm syntax highlighting across JS, TS, Python, Go, Rust, HTML, CSS, JSON, YAML and more
- 🪟 **Glass-morphism panels** — sidebar, editor, terminal and auxiliary bar with rounded corners, subtle borders and directional lighting
- 💊 **Pill-shaped activity bar** — floating, centered icons with an embossed active state
- 🌊 **Smooth animations** — breadcrumbs fade on hover, tab actions fade in, scrollbars transition on hover
- ✨ **File icon glow** — color-matched `drop-shadow` on file icons in the sidebar and tabs
- 🔔 **Rounded notifications** — toast and notification center with glass borders and deep shadows

---

## Installation

### One-liner

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/p-lozano/antigravity-dark-islands/main/install.sh)
```

### Manual

```bash
git clone https://github.com/p-lozano/antigravity-dark-islands
cd antigravity-dark-islands
bash install.sh
```

After installation, **restart Antigravity**.

> **"Corrupt installation" warning?** That's expected when CSS injection is active. Click the gear icon → **Don't Show Again**.

---

## Fonts

The theme looks best with these three fonts:

| Font | Used for | Download |
|------|----------|----------|
| **IBM Plex Mono** | Editor | [ibm.com/plex](https://www.ibm.com/plex/) |
| **FiraCode Nerd Font Mono** | Terminal | [nerdfonts.com](https://www.nerdfonts.com/) |
| **Bear Sans UI** | UI panels & tabs | [bwya77/vscode-dark-islands](https://github.com/bwya77/vscode-dark-islands) |

Place the `.otf` files in the `fonts/` folder and re-run `install.sh` — they'll be installed to Font Book automatically.

---

## How it works

The installer does 5 things:

1. **Copies the theme extension** to `~/.antigravity/extensions/`
2. **Installs [Custom UI Style](https://github.com/subframe7536/vscode-custom-ui-style)** via the Antigravity CLI (enables CSS injection)
3. **Installs fonts** to `~/Library/Fonts` (macOS) or `~/.local/share/fonts` (Linux)
4. **Merges settings** into `~/Library/Application Support/Antigravity/User/settings.json` — your existing settings are backed up first, nothing gets overwritten blindly
5. **Reloads Antigravity** to apply changes

### Why not just use the original installer?

Antigravity stores everything in different paths than VS Code:

| | VS Code | Antigravity |
|---|---|---|
| Extensions | `~/.vscode/extensions/` | `~/.antigravity/extensions/` |
| Settings | `~/Library/Application Support/Code/User/` | `~/Library/Application Support/Antigravity/User/` |
| CLI | `code` | `/Applications/Antigravity.app/Contents/Resources/app/bin/antigravity` |

---

## Credits

- Original theme and concept: [bwya77/vscode-dark-islands](https://github.com/bwya77/vscode-dark-islands)
- CSS injection engine: [subframe7536/custom-ui-style](https://github.com/subframe7536/vscode-custom-ui-style)

---

## License

MIT
