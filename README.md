# 🏝️ Islands Dark for Antigravity

A port of the [Islands Dark](https://github.com/bwya77/vscode-dark-islands) theme to **Google Antigravity IDE** — deep backgrounds, warm syntax highlighting, glass-like panels, rounded corners, and smooth animations.

> Built on the VS Code engine, Antigravity requires slightly different paths for extensions and settings. This repo handles all of that automatically.

![Islands Dark preview](https://raw.githubusercontent.com/bwya77/vscode-dark-islands/main/assets/preview.png)

---

## Features

- 🎨 **Islands Dark color theme** — deep `#131217` base with warm syntax highlighting
- 🪟 **Glass-morphism UI** — floating panels with rounded corners and directional lighting
- 💊 **Pill-shaped activity bar** — centered icons with subtle glow on active state
- 🌊 **Smooth animations** — transitions on breadcrumbs, tabs, status bar, and scrollbars
- ✨ **File icon glow** — color-matched drop-shadow on file icons in the sidebar and tabs

---

## Installation

### Automatic (recommended)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/p-lozano/antigravity-dark-islands/main/install.sh)
```

### Manual

1. Clone this repository:
   ```bash
   git clone https://github.com/p-lozano/antigravity-dark-islands
   cd antigravity-dark-islands
   ```

2. Run the installer:
   ```bash
   bash install.sh
   ```

3. Restart Antigravity.

4. If prompted with a *"corrupt installation"* warning, click the gear icon and select **Don't Show Again** — this is expected when CSS injection is active.

---

## Fonts

The theme looks best with these fonts:

| Font | Use | Download |
|------|-----|----------|
| **IBM Plex Mono** | Editor | [ibm.com/plex](https://www.ibm.com/plex/) |
| **FiraCode Nerd Font Mono** | Terminal | [nerdfonts.com](https://www.nerdfonts.com/) |
| **Bear Sans UI** | UI panels & tabs | [Original repo](https://github.com/bwya77/vscode-dark-islands) |

Place `.otf` files in the `fonts/` folder and re-run `install.sh` to install them automatically.

---

## How it works

This installer:

1. Copies the theme extension to `~/.antigravity/extensions/`
2. Installs [Custom UI Style](https://marketplace.visualstudio.com/items?itemName=subframe7536.custom-ui-style) via the Antigravity CLI
3. Merges the theme settings into `~/Library/Application Support/Antigravity/User/settings.json` (your existing settings are backed up first)

### Path differences vs. VS Code

| | VS Code | Antigravity |
|---|---|---|
| Extensions | `~/.vscode/extensions/` | `~/.antigravity/extensions/` |
| Settings | `~/Library/Application Support/Code/User/` | `~/Library/Application Support/Antigravity/User/` |
| CLI | `code` | `/Applications/Antigravity.app/Contents/Resources/app/bin/antigravity` |

---

## Credits

- Original theme: [bwya77/vscode-dark-islands](https://github.com/bwya77/vscode-dark-islands)
- CSS injection: [subframe7536/custom-ui-style](https://github.com/subframe7536/vscode-custom-ui-style)

## License

MIT
