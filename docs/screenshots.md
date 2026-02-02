# 🐺 LXR BLACKOUT SYSTEM - SCREENSHOTS GUIDE

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║    ██╗     ██╗  ██╗██████╗     ██████╗ ██╗      █████╗  ██████╗██╗  ██╗    ║
║    ██║     ╚██╗██╔╝██╔══██╗    ██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝    ║
║    ██║      ╚███╔╝ ██████╔╝    ██████╔╝██║     ███████║██║     █████╔╝     ║
║    ██║      ██╔██╗ ██╔══██╗    ██╔══██╗██║     ██╔══██║██║     ██╔═██╗     ║
║    ███████╗██╔╝ ██╗██║  ██║    ██████╔╝███████╗██║  ██║╚██████╗██║  ██╗    ║
║    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ║
║                                                                              ║
║                  🐺 SCREENSHOTS & ASSETS GUIDE 🐺                            ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

---

## 📋 OVERVIEW

This document outlines the required screenshots and visual assets for the LXR Blackout System documentation and promotional materials.

---

## 📸 REQUIRED SCREENSHOTS

### Asset Directory Structure

```
docs/
└── assets/
    └── screenshots/
        ├── 01_startup_console.png
        ├── 02_config_sections.png
        ├── 03_ui_interaction.png
        ├── 04_framework_detection.png
        ├── 05_discord_logs.png
        └── 06_txadmin_performance.png
```

---

## 🖼️ SCREENSHOT SPECIFICATIONS

### 1. Startup Console (`01_startup_console.png`)

**Purpose:** Show the system boot banner and initialization  
**Dimensions:** 1920x1080 or 1280x720  
**Format:** PNG  
**Background:** Dark console/terminal

**Required Elements:**
- ASCII art banner (LXR BLACKOUT)
- 🐺 Wolf emoji visible
- Framework detection message
- "System loaded successfully" message
- Zone count message
- Generator count message
- Server info (The Land of Wolves)

**Example Content:**
```
╔══════════════════════════════════════════════════════════════╗
║   LXR BLACKOUT                                               ║
║   🐺 REGIONAL BLACKOUT SYSTEM 🐺                             ║
║                                                              ║
║   Version:  v3.0.0 (LXR Edition)                            ║
║   Server:   The Land of Wolves 🐺                            ║
╚══════════════════════════════════════════════════════════════╝

[LXR-BLACKOUT] 🔍 Detecting framework...
[LXR-BLACKOUT] ✅ Found RSG-Core (resource: rsg-core)
[LXR-BLACKOUT] 🎯 Framework initialized: RSG-Core
[LXR-BLACKOUT] ✅ System loaded successfully
[LXR-BLACKOUT] ✅ Loaded 2 zones
[LXR-BLACKOUT] ✅ Loaded 3 generators
```

**Capture Instructions:**
1. Restart `lxr_blackout` resource
2. Open server console (F8 or server terminal)
3. Capture full boot sequence
4. Ensure green colors visible for success messages

---

### 2. Config Sections (`02_config_sections.png`)

**Purpose:** Showcase the organized configuration structure  
**Dimensions:** 1920x1080 (full IDE/editor view)  
**Format:** PNG  
**Background:** Code editor with syntax highlighting

**Required Elements:**
- Multiple config sections visible
- `Config.ServerInfo` section
- `Config.PowerZones` section
- `Config.Generators` section
- `Config.Security` section
- Syntax highlighting (VS Code/Sublime/Notepad++)
- Line numbers visible
- Comments visible

**Recommended Editor Settings:**
- Theme: Dark (One Dark, Monokai, Dracula)
- Font: Fira Code, JetBrains Mono, Cascadia Code
- Syntax: Lua highlighting
- Zoom: 100-110%

**Capture Instructions:**
1. Open `shared/config.lua`
2. Scroll to show multiple sections
3. Ensure comments and structure visible
4. Capture clean editor view

---

### 3. UI Interaction (`03_ui_interaction.png`)

**Purpose:** Show in-game player interaction with generators  
**Dimensions:** 1920x1080 (in-game screenshot)  
**Format:** PNG  
**Background:** In-game environment

**Required Elements:**
- Generator prop visible
- Interaction prompt visible (`[E] Repair Generator` or similar)
- Generator blip on minimap (if applicable)
- Player character visible (optional)
- HUD elements (health, stamina, etc.)
- Notification or prompt text clear
- Good lighting/visibility

**Scenarios to Capture:**
- **Option A:** Player approaching generator with prompt
- **Option B:** Minigame UI (skill check, MGC game)
- **Option C:** Success notification after repair

**Capture Instructions:**
1. Navigate to generator location in-game
2. Position camera for clear view
3. Ensure prompt/UI is visible
4. Capture at 1920x1080 resolution
5. Use high graphics settings

---

### 4. Framework Detection (`04_framework_detection.png`)

**Purpose:** Demonstrate multi-framework compatibility  
**Dimensions:** 1920x1080 or split-screen  
**Format:** PNG  
**Background:** Console or split comparison

**Required Elements:**
- Framework detection messages for multiple frameworks
- At least 2 framework examples (RSG-Core, VORP, QBCore, etc.)
- Clear indication of successful detection
- Framework name clearly visible
- Resource name visible

**Example Content:**
```
# RSG-Core Detection:
[LXR-BLACKOUT] ✅ Found RSG-Core (resource: rsg-core)
[LXR-BLACKOUT] 🎯 Framework initialized: RSG-Core

# VORP Detection:
[LXR-BLACKOUT] ✅ Found VORP (resource: vorp_core)
[LXR-BLACKOUT] 🎯 Framework initialized: VORP

# QBCore Detection:
[LXR-BLACKOUT] ✅ Found QBCore (resource: qb-core)
[LXR-BLACKOUT] 🎯 Framework initialized: QBCore
```

**Capture Instructions:**
1. Test on multiple framework servers OR
2. Create composite image showing multiple detections
3. Ensure all text is readable
4. Highlight framework names in green

---

### 5. Discord Logs (`05_discord_logs.png`)

**Purpose:** Showcase Discord webhook integration and logging  
**Dimensions:** 1920x1080 or 1280x720  
**Format:** PNG  
**Background:** Discord interface (web or desktop)

**Required Elements:**
- Discord channel with webhook messages
- At least 3 different log types visible:
  - Generator sabotage log
  - Generator repair log
  - Blackout zone state change
  - (Optional) Intel purchase log
  - (Optional) Security alert
- Embed formatting visible (colors, fields, timestamps)
- Bot name: "LXR Blackout System" (or configured name)
- Wolf emoji 🐺 in messages
- Timestamps visible
- Player information in fields

**Example Log Embeds:**
```
🚨 GENERATOR SABOTAGED
Downtown Main Generator has been sabotaged!

Player: John_Doe [42]
Generator: gen_downtown_main
Location: Downtown Los Santos
Timestamp: 2025-01-17 15:30:45
[Red color embed]

✅ GENERATOR REPAIRED
Downtown Main Generator has been repaired!

Player: Jane_Smith [83]
Generator: gen_downtown_main
Reward: $500
Timestamp: 2025-01-17 15:35:12
[Green color embed]

⚡ BLACKOUT ACTIVATED
Downtown Los Santos is now in blackout!

Zone: downtown
Active Generators: 0/2
Duration: Active until repair
Timestamp: 2025-01-17 15:30:50
[Orange color embed]
```

**Capture Instructions:**
1. Trigger several in-game actions
2. Open Discord channel with webhook
3. Capture multiple log embeds
4. Ensure colors and formatting visible
5. Crop to relevant content

---

### 6. txAdmin Performance (`06_txadmin_performance.png`)

**Purpose:** Demonstrate excellent performance metrics  
**Dimensions:** 1920x1080  
**Format:** PNG  
**Background:** txAdmin web interface

**Required Elements:**
- txAdmin resources page visible
- `lxr_blackout` resource highlighted
- Performance metrics clearly visible:
  - Average tick time: <0.05ms
  - Peak tick time: <0.10ms
  - Memory usage: <50MB
  - Status: Running (green)
- Resource list showing other resources for comparison
- Clean, professional appearance

**Metric Targets:**
- **Idle:** 0.00ms
- **Active:** 0.01-0.05ms
- **Peak:** <0.10ms
- **Memory:** 30-50MB

**Capture Instructions:**
1. Access txAdmin web interface
2. Navigate to Resources page
3. Let server run for 5+ minutes for accurate metrics
4. Capture during active gameplay
5. Ensure `lxr_blackout` is visible
6. Highlight/annotate performance numbers (optional)

---

## 🎨 VISUAL GUIDELINES

### Image Quality Standards

- **Resolution:** Minimum 1280x720, preferred 1920x1080
- **Format:** PNG (lossless) or high-quality JPG (90%+)
- **File Size:** <5MB per image (optimize if needed)
- **Clarity:** Sharp text, no blur
- **Brightness:** Adequate visibility, not too dark
- **Colors:** Accurate representation, not oversaturated

### Composition Guidelines

- **Framing:** Include relevant UI elements, exclude clutter
- **Focus:** Main subject clear and centered
- **Context:** Enough surroundings to understand context
- **Text Readability:** All text must be legible at 100% zoom

### Brand Consistency

- **Wolf Emoji:** 🐺 Should be visible in brand-related screenshots
- **Colors:** Use brand colors (red, green, blue for states)
- **Font:** Code should use monospace font with syntax highlighting
- **Logos:** Include "The Land of Wolves" or "LXR" branding where appropriate

---

## 🛠️ CAPTURE TOOLS

### Recommended Tools

**In-Game Screenshots:**
- FiveM/RedM built-in: F8 → `screenshot` command
- NVIDIA GeForce Experience: Alt+F1
- Windows Snipping Tool: Win+Shift+S
- ShareX: Customizable capture tool

**Console/Editor Screenshots:**
- Windows Snipping Tool: Win+Shift+S
- ShareX: Screen capture
- Lightshot: Quick upload
- Greenshot: Professional annotation

**Discord Screenshots:**
- Discord built-in: Right-click → Copy Image
- Browser developer tools: High-DPI capture
- ShareX: Region capture

**txAdmin Screenshots:**
- Browser screenshot extension (FireShot, Awesome Screenshot)
- OS screenshot tool
- Browser native: Ctrl+Shift+S (Firefox)

---

## 📝 ANNOTATION & EDITING

### Optional Annotations

For tutorial/guide screenshots, consider adding:

- **Arrows:** Point to important elements
- **Boxes:** Highlight specific sections
- **Text Labels:** Explain features
- **Numbers:** Step-by-step instructions

### Recommended Tools

- **ShareX:** Built-in annotation
- **Greenshot:** Annotation editor
- **Paint.NET:** Free image editor
- **GIMP:** Advanced free editor
- **Photoshop:** Professional (if available)

### Annotation Guidelines

- **Color:** Red for highlights, white/yellow for text
- **Font:** Clear sans-serif (Arial, Roboto)
- **Size:** Large enough to read at 1920x1080
- **Style:** Simple, not distracting
- **Consistency:** Use same style across all screenshots

---

## 📤 SUBMISSION CHECKLIST

Before finalizing screenshots:

- [ ] **All 6 required screenshots** captured
- [ ] **Correct file names** (01-06 with descriptive names)
- [ ] **Correct format** (PNG preferred)
- [ ] **Correct resolution** (1280x720 minimum)
- [ ] **File size optimized** (<5MB each)
- [ ] **Text is readable** at 100% zoom
- [ ] **No personal information** (if applicable)
- [ ] **No inappropriate content**
- [ ] **Brand elements visible** (🐺, logos)
- [ ] **Professional appearance**
- [ ] **Color accuracy** maintained
- [ ] **Placed in correct directory** (`docs/assets/screenshots/`)

---

## 🖼️ USAGE PERMISSIONS

### Internal Documentation
✅ Use in README, docs, wikis  
✅ Use in Discord server  
✅ Use in GitHub repository

### Promotional Use
✅ Use in promotional materials  
✅ Use on social media  
✅ Use in store listings  
⚠️ Credit "The Land of Wolves" when applicable

### Restrictions
❌ Do not alter logos or branding  
❌ Do not remove wolf emoji 🐺  
❌ Do not misrepresent functionality  
❌ Do not use for competing products

---

## 📞 SCREENSHOT SUPPORT

Need help capturing or creating screenshots?

**Discord:** https://discord.gg/CrKcWdfd3A  
**GitHub:** https://github.com/iBoss21  
**Website:** https://www.wolves.land

We can provide:
- Sample screenshots
- Capture assistance
- Editing help
- Alternative formats

---

## 🎯 SCREENSHOT SUMMARY

```
═══════════════════════════════════════════════════════════════
Screenshot                    Purpose                 Status
═══════════════════════════════════════════════════════════════
01_startup_console.png        Boot banner             ⏳ Pending
02_config_sections.png        Config structure        ⏳ Pending
03_ui_interaction.png         Player interaction      ⏳ Pending
04_framework_detection.png    Multi-framework         ⏳ Pending
05_discord_logs.png           Webhook logging         ⏳ Pending
06_txadmin_performance.png    Performance metrics     ⏳ Pending
═══════════════════════════════════════════════════════════════
```

---

## 🌟 SHOWCASE EXAMPLES

### Professional Screenshot Gallery

Once captured, screenshots will be used in:

1. **README.md** - Feature showcase
2. **Installation Guide** - Visual setup instructions
3. **Configuration Guide** - Config section examples
4. **Discord Server** - Feature announcements
5. **Store Listings** - Product page (if applicable)
6. **Social Media** - Promotional posts

### Gallery Layout Example

```markdown
## 📸 Screenshots

### System Initialization
![Startup Console](docs/assets/screenshots/01_startup_console.png)

### Configuration
![Config Sections](docs/assets/screenshots/02_config_sections.png)

### In-Game Interaction
![UI Interaction](docs/assets/screenshots/03_ui_interaction.png)

### Framework Compatibility
![Framework Detection](docs/assets/screenshots/04_framework_detection.png)

### Discord Integration
![Discord Logs](docs/assets/screenshots/05_discord_logs.png)

### Performance
![txAdmin Performance](docs/assets/screenshots/06_txadmin_performance.png)
```

---

**Built with 🐺 by The Land of Wolves Community**

```
════════════════════════════════════════════════════════════════════════════
Visual documentation brings features to life.
© 2026 The Lux Empire | wolves.land | All Rights Reserved
════════════════════════════════════════════════════════════════════════════
```
