#!/bin/bash

set -e

echo "🏝️  Islands Dark Theme Installer for Antigravity"
echo "================================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if antigravity command is available
ANTIGRAVITY_CLI=""
if command -v antigravity &> /dev/null; then
    ANTIGRAVITY_CLI="antigravity"
elif [ -f "/usr/local/bin/antigravity" ]; then
    ANTIGRAVITY_CLI="/usr/local/bin/antigravity"
elif [ -f "/Applications/Antigravity.app/Contents/Resources/app/bin/antigravity" ]; then
    ANTIGRAVITY_CLI="/Applications/Antigravity.app/Contents/Resources/app/bin/antigravity"
else
    echo -e "${RED}❌ Error: Antigravity CLI not found!${NC}"
    echo "Please install Antigravity and make sure 'antigravity' command is in your PATH."
    echo "You can do this by:"
    echo "  1. Open Antigravity"
    echo "  2. Press Cmd+Shift+P"
    echo "  3. Type 'Shell Command: Install antigravity command in PATH'"
    exit 1
fi

echo -e "${GREEN}✓ Antigravity CLI found: $ANTIGRAVITY_CLI${NC}"

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo ""
echo "📦 Step 1: Installing Islands Dark theme extension..."

# Install to Antigravity extensions directory
EXT_DIR="$HOME/.antigravity/extensions/bwya77.islands-dark-1.0.0"
rm -rf "$EXT_DIR"
mkdir -p "$EXT_DIR"
cp "$SCRIPT_DIR/package.json" "$EXT_DIR/"
cp -r "$SCRIPT_DIR/themes" "$EXT_DIR/"

if [ -d "$EXT_DIR/themes" ]; then
    echo -e "${GREEN}✓ Theme extension installed to $EXT_DIR${NC}"
else
    echo -e "${RED}❌ Failed to install theme extension${NC}"
    exit 1
fi

echo ""
echo "🔧 Step 2: Installing Custom UI Style extension..."
if "$ANTIGRAVITY_CLI" --install-extension subframe7536.custom-ui-style --force 2>/dev/null; then
    echo -e "${GREEN}✓ Custom UI Style extension installed${NC}"
else
    echo -e "${YELLOW}⚠️  Could not install Custom UI Style extension automatically${NC}"
    echo "   Please install 'Custom UI Style' (subframe7536.custom-ui-style) manually from the Extensions marketplace"
fi

echo ""
echo "🔤 Step 3: Installing Bear Sans UI fonts..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    FONT_DIR="$HOME/Library/Fonts"
    if ls "$SCRIPT_DIR/fonts/"*.otf &>/dev/null 2>&1; then
        echo "   Installing fonts to: $FONT_DIR"
        cp "$SCRIPT_DIR/fonts/"*.otf "$FONT_DIR/" 2>/dev/null || true
        echo -e "${GREEN}✓ Fonts installed to Font Book${NC}"
        echo "   Note: You may need to restart applications to use the new fonts"
    else
        echo -e "${YELLOW}⚠️  No fonts found in fonts/ folder${NC}"
        echo "   Download Bear Sans UI from: https://github.com/bwya77/vscode-dark-islands"
        echo "   IBM Plex Mono: https://www.ibm.com/plex/"
        echo "   FiraCode Nerd Font: https://www.nerdfonts.com/"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    if ls "$SCRIPT_DIR/fonts/"*.otf &>/dev/null 2>&1; then
        echo "   Installing fonts to: $FONT_DIR"
        cp "$SCRIPT_DIR/fonts/"*.otf "$FONT_DIR/" 2>/dev/null || true
        fc-cache -f 2>/dev/null || true
        echo -e "${GREEN}✓ Fonts installed${NC}"
    else
        echo -e "${YELLOW}⚠️  No fonts found in fonts/ folder${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Could not detect OS type for font installation${NC}"
    echo "   Please manually install the fonts from the 'fonts/' folder"
fi

echo ""
echo "⚙️  Step 4: Applying Antigravity settings..."

SETTINGS_DIR="$HOME/Library/Application Support/Antigravity/User"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    SETTINGS_DIR="$HOME/.config/Antigravity/User"
fi

mkdir -p "$SETTINGS_DIR"
SETTINGS_FILE="$SETTINGS_DIR/settings.json"

if [ -f "$SETTINGS_FILE" ]; then
    echo -e "${YELLOW}⚠️  Existing settings.json found${NC}"
    echo "   Backing up to settings.json.backup"
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"

    echo "   Merging Islands Dark settings with your existing settings..."

    if command -v node &> /dev/null; then
        SCRIPT_DIR_ESCAPED="${SCRIPT_DIR//\\/\\\\}"
        node << NODE_SCRIPT
const fs = require('fs');
const path = require('path');

function stripJsonc(text) {
    text = text.replace(/\/\/(?=(?:[^"\\\\]|\\\\.)*$)/gm, '');
    text = text.replace(/\/\*[\s\S]*?\*\//g, '');
    text = text.replace(/,\s*([}\]])/g, '\$1');
    return text;
}

const scriptDir = '${SCRIPT_DIR_ESCAPED}';
const newSettings = JSON.parse(stripJsonc(fs.readFileSync(path.join(scriptDir, 'settings.json'), 'utf8')));

let settingsDir;
if (process.platform === 'darwin') {
    settingsDir = path.join(process.env.HOME, 'Library/Application Support/Antigravity/User');
} else {
    settingsDir = path.join(process.env.HOME, '.config/Antigravity/User');
}

const settingsFile = path.join(settingsDir, 'settings.json');
const existingText = fs.readFileSync(settingsFile, 'utf8');
const existingSettings = JSON.parse(stripJsonc(existingText));

const mergedSettings = { ...existingSettings, ...newSettings };

const stylesheetKey = 'custom-ui-style.stylesheet';
if (existingSettings[stylesheetKey] && newSettings[stylesheetKey]) {
    mergedSettings[stylesheetKey] = {
        ...existingSettings[stylesheetKey],
        ...newSettings[stylesheetKey]
    };
}

fs.writeFileSync(settingsFile, JSON.stringify(mergedSettings, null, 2));
console.log('Settings merged successfully');
NODE_SCRIPT
        echo -e "${GREEN}✓ Settings merged${NC}"
    else
        echo -e "${YELLOW}   Node.js not found. Please manually merge settings.json from this repo into your Antigravity settings.${NC}"
        echo "   Your original settings have been backed up to settings.json.backup"
    fi
else
    cp "$SCRIPT_DIR/settings.json" "$SETTINGS_FILE"
    echo -e "${GREEN}✓ Settings applied${NC}"
fi

echo ""
echo "🚀 Step 5: Enabling Custom UI Style..."

FIRST_RUN_FILE="$SCRIPT_DIR/.islands_dark_first_run"
if [ ! -f "$FIRST_RUN_FILE" ]; then
    touch "$FIRST_RUN_FILE"
    echo ""
    echo -e "${YELLOW}📝 Important Notes:${NC}"
    echo "   • IBM Plex Mono and FiraCode Nerd Font Mono need to be installed separately"
    echo "   • After Antigravity reloads, you may see a 'corrupt installation' warning"
    echo "   • This is expected — click the gear icon and select 'Don't Show Again'"
    echo "   • Bear Sans UI font can be downloaded from the original repo:"
    echo "     https://github.com/bwya77/vscode-dark-islands"
    echo ""
    if [ -t 0 ]; then
        read -p "Press Enter to continue and reload Antigravity..."
    fi
fi

echo "   Applying CSS customizations..."
echo -e "${GREEN}✓ Setup complete!${NC}"
echo ""
echo "🎉 Islands Dark theme has been installed in Antigravity!"
echo "   Antigravity will now reload to apply the custom UI style."
echo ""

if [[ "$OSTYPE" == "darwin"* ]]; then
    osascript -e 'display notification "Islands Dark theme installed successfully!" with title "🏝️ Islands Dark for Antigravity"' 2>/dev/null || true
fi

echo "   Reloading Antigravity..."
"$ANTIGRAVITY_CLI" --reload-window 2>/dev/null || "$ANTIGRAVITY_CLI" . 2>/dev/null || true

echo ""
echo -e "${GREEN}Done! 🏝️${NC}"
