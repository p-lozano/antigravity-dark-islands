# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository ports the Islands Dark VS Code theme to Google Antigravity IDE. Antigravity is built on the VS Code engine but uses different file paths for extensions and settings, so this port provides an automated installer that handles the differences.

The theme combines:
- A color theme extension (standard VS Code theme format)
- Extensive CSS customizations via the Custom UI Style extension
- Custom fonts (Bear Sans UI, IBM Plex Mono, FiraCode Nerd Font Mono)

## Installation & Testing

### Running the installer
```bash
bash install.sh
```

### Testing the one-liner bootstrap
```bash
bash bootstrap.sh
```

### Running the uninstaller
```bash
bash uninstall.sh
```

The installer performs these steps:
1. Copies the theme extension to `~/.antigravity/extensions/bwya77.islands-dark-1.0.0/`
2. Installs the `subframe7536.custom-ui-style` extension via Antigravity CLI
3. Installs fonts to `~/Library/Fonts` (macOS) or `~/.local/share/fonts` (Linux)
4. Merges `settings.json` into Antigravity's user settings
5. Reloads Antigravity to apply changes

The uninstaller performs these steps:
1. Removes the theme extension from `~/.antigravity/extensions/`
2. Optionally uninstalls the Custom UI Style extension (prompts user)
3. Restores `settings.json` from backup if available (prompts user)
4. Removes the `.islands_dark_first_run` marker file
5. Reloads Antigravity to apply changes
6. Does NOT remove fonts (they may be used by other applications)

## Architecture

### Theme Extension Structure

The theme is a standard VS Code theme extension:
- `package.json` - Extension manifest defining the theme contribution
- `themes/islands-dark.json` - Color theme definition with tokenColors and workbench colors

The extension is manually copied to `~/.antigravity/extensions/` rather than installed via the marketplace since it's a port of an existing theme.

### CSS Customization System

The visual customizations (glass-morphism panels, pill-shaped activity bar, rounded corners, etc.) are NOT part of the color theme. They're injected via the Custom UI Style extension using the `custom-ui-style.stylesheet` setting.

This two-layer approach exists because:
- VS Code themes can only control **colors**, not layout, borders, or animations
- CSS injection via Custom UI Style allows morphological changes to the UI elements
- The CSS rules in `settings.json` target specific workbench DOM elements

### Settings Merging

The installer intelligently merges settings rather than overwriting:

1. If `settings.json` exists in Antigravity, it backs up to `settings.json.backup`
2. Uses Node.js script to parse both files (stripping JSONC comments)
3. Merges settings with new values taking precedence
4. Special handling for `custom-ui-style.stylesheet`: deep merges the stylesheet object to preserve any existing custom CSS rules

If Node.js is not available, the installer warns the user to manually merge settings.

## Platform-Specific Paths

### Antigravity vs VS Code Paths

| Resource | VS Code | Antigravity |
|----------|---------|-------------|
| Extensions | `~/.vscode/extensions/` | `~/.antigravity/extensions/` |
| User Settings (macOS) | `~/Library/Application Support/Code/User/` | `~/Library/Application Support/Antigravity/User/` |
| User Settings (Linux) | `~/.config/Code/User/` | `~/.config/Antigravity/User/` |
| CLI Command | `code` | `antigravity` or `/Applications/Antigravity.app/Contents/Resources/app/bin/antigravity` |

### CLI Detection

The installer checks for the Antigravity CLI in this order:
1. `antigravity` command in PATH
2. `/usr/local/bin/antigravity`
3. `/Applications/Antigravity.app/Contents/Resources/app/bin/antigravity`

If none found, it instructs the user to install the shell command via Antigravity's command palette.

## Key Files

- `install.sh` - Main installer that handles all 5 installation steps
- `uninstall.sh` - Uninstaller that removes the theme and optionally restores settings
- `bootstrap.sh` - One-liner wrapper that clones the repo to a temp directory and runs `install.sh`
- `settings.json` - Complete Antigravity settings including the massive CSS stylesheet
- `package.json` - VS Code theme extension manifest
- `themes/islands-dark.json` - Color theme definition
- `.islands_dark_first_run` - Marker file created on first run to show installation notes only once

## Expected Warnings

After installation, Antigravity shows a "corrupt installation" warning because Custom UI Style modifies internal files. This is expected behavior - users should click the gear icon and select "Don't Show Again."
