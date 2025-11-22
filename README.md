# ✨💻 Minimalist & Optimized Hyprland Rice

🔧 Clean  
⚡ Blazing Fast Performance  
🎯 Smart Keybinds  
🧠 Low Learning Curve  
📦 One-Command Setup  

---

## 🖼️ Preview 

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/5ef882bf-2e34-4b27-8dd9-be0d57cbf803" />

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/04c9625c-b0e8-448c-882e-c4ad214240d6" />

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/704a6f9b-3cb0-4fab-9466-855c09b5cd78" />

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/e6e15140-6bd1-4ba1-a4b0-bb05a0738058" />

<img width="1920" height="1080" alt="20251122_20h07m58s_grim" src="https://github.com/user-attachments/assets/97feee29-ba02-4a02-9e30-771c3a6a1d98" />

<img width="1920" height="1080" alt="20251122_20h10m13s_grim" src="https://github.com/user-attachments/assets/139e8f7b-3773-4d87-9593-5f684d0e8740" />

---

## 📦 Packages

🖥️ **Ghostty** – GPU-accelerated terminal  
💤 **Rofi** – App launcher  
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
~/.config/hypr/scripts/gameboost.sh
```

4. **Set the post-game script** to:

```bash
~/.config/hypr/scripts/normalmode.sh
```

> This will automatically optimize your system for gaming when a game starts, and restore normal settings when you exit.

---

## 📚 Default Programs

* Terminal: `ghostty`
* Launcher: `walker`
* File Manager: `thunar`
* Browser: `chrome`
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
| Code Editor                  | mainMod + W             |
| Full Screenshot              | mainMod + S             |
| Region Screenshot            | mainMod + Shift + S     |
| Toggle Waybar                | mainMod + A             |
| Next Window                  | mainMod + Tab           |
| Previous Window              | mainMod + Shift + Tab   |
| Fullscreen Toggle            | mainMod + F             |
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
| Toggle Gaming Mode           | mainMod + F1            |
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
