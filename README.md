# ✨💻 Minimalist & Optimized Hyprland Rice

🔧 Clean  
⚡ Blazing Fast Performance  
🎯 Smart Keybinds  
🧠 Low Learning Curve  
📦 One-Command Setup  

---

## 🖼️ Preview 

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/097ccab9-2f0c-46c4-8a08-5b5795e733c6" />

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/b28abb16-f371-4610-9f3c-e58f7dadd919" />

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/ca1f5dc1-bed8-40a8-9710-38a5d14d3f90" />

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/d3f3425b-a801-4a62-87d7-503f3cabf882" />

<img width="1920" height="1080" alt="20251021_13h21m00s_grim" src="https://github.com/user-attachments/assets/f784d568-c23b-4bd2-a095-626018d6d980" />


---

## 📦 Requirements

🖥️ **Kitty** – GPU-accelerated terminal  
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

* Terminal: `kitty`
* Launcher: `~/.config/rofi/launcher.sh`
* File Manager: `thunar`
* Browser: `zen-browser`
* Power Menu: `wlogout`
* Code Editor: `code`

---

## 🎮 Keybindings (Using `mainMod`)

| Action                       | Shortcut                |
| ---------------------------- | ----------------------- |
| Open Terminal                | mainMod + Return        |
| App Launcher (Rofi)          | mainMod + Space         |
| File Manager (Thunar)        | mainMod + E             |
| Web Browser (Zen)            | mainMod + B             |
| Obsidian                     | mainMod + O             |
| Code Editor (VSCode)         | mainMod + W             |
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
