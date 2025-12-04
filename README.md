# ✨💻 Minimalist & Optimized Hyprland Rice

🔧 Clean  
⚡ Blazing Fast Performance  
🎯 Smart Keybinds  
🧠 Low Learning Curve  
📦 One-Command Setup  

---

## 🖼️ Preview 

<img width="1920" height="1080" alt="20251204_11h45m13s_grim" src="https://github.com/user-attachments/assets/344e97bc-ca81-43a4-9a48-41263ff69dbe" />

<img width="1920" height="1080" alt="20251204_11h16m12s_grim" src="https://github.com/user-attachments/assets/9f3cfe10-b928-4b63-9fa3-96cbf6c88fb0" />

<img width="1920" height="1080" alt="20251204_11h16m48s_grim" src="https://github.com/user-attachments/assets/adcdaf40-291e-44cf-8464-c7c01a8dd727" />

<img width="1920" height="1080" alt="20251204_11h42m17s_grim" src="https://github.com/user-attachments/assets/bfe834bb-da2b-49d5-a0f1-f508c3588437" />

<img width="1920" height="1080" alt="20251204_11h49m24s_grim" src="https://github.com/user-attachments/assets/206cba3c-99c7-47d5-b1b8-f0077b4955b0" />

---

## 📦 Packages

🖥️ **Kitty** – terminal  
💤 **walker** – App launcher  
🌀 **Hyprland** – Next-gen Wayland compositor  
🖼️ **Hyprpaper** – Wallpaper manager  
📏 **Slurp** – Region selector for screenshots  
🧩 **Waybar** – Customizable status bar  
🎨 **Fastfetch** – System info displayed on startup  
🧠 **JetBrains Mono** – Developer-friendly programming font  
🔒 **wlogout** – Graphical logout menu for Wayland  
🛡️ **hyprpolkit-agent** – Polkit authentication agent for Hyprland  
💽 **udiskie** – Auto-mount and manage removable drives  
🔒 **hyprlock** – Lock screen  
⏱️ **hypridle** – Idle management  
📝 **jq** – JSON processor  

---

## 📥 One-Command Installation

```bash
git clone https://github.com/TON-USERNAME/my-hyprland-dotfile
cd my-hyprland-dotfile
chmod +x install.sh
./install.sh
````

---


## 🎮 How to Use Gaming Mode

To enable Gaming Mode:

1. **Open Heroic Game Launcher**.
2. **Go to the game’s settings**.
3. **Set the launch script** to:

```bash
~/.config/hypr/scri Drag additional files here to add them to your repository

Or
/nvim/lua/plugins/rustace.lua
Uploading 12 of 22 files
/Assets/snorlax2.png
/Assets/pixel.png
/Assets/aesthetic.jpg
/Assets/404-error-purple-3840x2160-18308.jpg
pts/gameboost.sh
```

4. **Set the post-game script** to:

```bash
~/.config/hypr/scripts/normalmode.sh
```

> This will automatically optimize your system for gaming when a game starts, and restore normal settings when you exit.

---

## 📚 Default Programs

* Terminal: `kitty`
* Launcher: `walker`
* File Manager: `thunar`
* Browser: `zen browser`
* Power Menu: `wlogout`
* Code Editor: `nvim`

---

## 🎮 Keybindings (Using `mainMod`)

| Action                       | Shortcut                |
| ---------------------------- | ----------------------- |
| Open Terminal                | mainMod + Return        |
| App Launcher                 | mainMod + Space         |
| File Manager (Thunar)        | mainMod + E             |
| Web Browser                  | mainMod + B             |
| Obsidian                     | mainMod + O             |
| Fullscreen                   | mainMod + W             |
| Full Screenshot              | mainMod + S             |
| Region Screenshot            | mainMod + Shift + S     |
| Toggle Waybar                | mainMod + A             |
| Next Window                  | mainMod + Tab           |
| Previous Window              | mainMod + Shift + Tab   |
| Exclusive Fullscreen         | mainMod + F             |
| Toggle Floating              | mainMod + T             |
| Toggle Pseudotile            | mainMod + P             |
| Toggle Split Orientation     | mainMod + J             |
| Move Focus (Arrow Keys)      | mainMod + ↑↓←→          |
| Resize (Arrow Keys)          | mainMod + Shift + ↑↓←→  |
| Move Window to WS 1–9        | mainMod + Shift + [1–9] |
| Move Window to WS 10         | mainMod + Shift + 0     |
| Switch to WS 1–9             | mainMod + [1–9]         |
| Workspace Scroll             | mainMod + Mouse Wheel   |
| Move Window (Mouse)          | mainMod + Left Click    |
| Resize Window (Mouse)        | mainMod + Right Click   |
| Close Window                 | mainMod + Q             |
| Exit Session                 | mainMod + M             |
| Volume Up                    | mainMod + F7            |
| Volume Down                  | mainMod + F6            |
| Mute                         | mainMod + F5            |
| Brightness Up                | mainMod + F4            |
| Brightness Down              | mainMod + F3            |
| Resize Window (Shift+Arrows) | mainMod + Shift + ↑↓←→  |
| Swap with Master (↑)         | mainMod + Ctrl + ↑      |
| Roll Master Next/Prev        | mainMod + Ctrl + ← / →  |
| Lock Screen                  | mainMod + L             |

💡 All keybindings are located in `~/.config/hypr/hyprland.conf` and easily modifiable.

---

## 🪟 Window Rules & Workspaces

* Workspace 1 → zen / firefox / chrome
* Workspace 2 → Code / Zed / Godot / Blender
* Workspace 3 → VLC
* Workspace 4 → virt-manager
* Workspace 5 → for playing games

---

## 🎨 Customize It Your Way

* Default apps: `$terminal`, `$browser`, `$fileManager`
* Bar modules: edit `~/.config/waybar/config`
* Wallpaper: Hyprpaper
* Layout: master-based with configurable behavior

---

## ⚡ Features

* Master layout with roll/swapping support
* Smart workspace assignments by app
* Gaming Mode
* Floating rules and opacity per window
* Smooth animations with Bézier curves
* Blur & shadows for depth
* NVIDIA and VM-ready environment

---

## 📚 Learn More

* 🧪 Hyprland Wiki → [https://wiki.hyprland.org](https://wiki.hyprland.org)
