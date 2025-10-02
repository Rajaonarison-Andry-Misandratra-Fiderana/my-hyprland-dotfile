# ✨💻 Minimalist & Optimized Hyprland Rice

🔧 Clean  
⚡ Blazing Fast Performance  
🎯 Smart Keybinds  
🧠 Low Learning Curve  
📦 One-Command Setup  

---

## 🖼️ Preview 
<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/3cdb0985-e6f7-4145-a923-6b52f8bf5d0b" />

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/92ab1970-52c3-4256-b5b1-224438f2f7f4" />

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/3dce914a-6258-45d9-be6b-962d8a45d369" />

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/bf0bc494-3b22-45da-864e-a452eb6650dd" />

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/66f581f8-180a-4717-ae97-aca7ec9c87b6" />

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

## 🖥️ Monitors

* eDP-1: 1920x1080@60, primary
* HDMI-A-4: 1920x1080@60, secondary

---

## ⚙️ Environment / NVIDIA / VM

* GBM_BACKEND=nvidia
* LIBVA_DRIVER_NAME=nvidia
* SDL_VIDEODRIVER=wayland
* __GLX_VENDOR_LIBRARY_NAME=nvidia
* __NV_PRIME_RENDER_OFFLOAD=1
* __VK_LAYER_NV_optimus=NVIDIA_only
* MOZ_DISABLE_RDD_SANDBOX=1
* EGL_PLATFORM=wayland
* WLR_NO_HARDWARE_CURSORS=1
* WLR_RENDERER_ALLOW_SOFTWARE=1

---

## 🏁 Autostart Programs

* `hyprctl setcursor Bibata-Modern-Classic 24`
* `waybar`
* `hyprpaper`
* `systemctl --user start hyprpolkitagent`
* `nm-applet`
* `udiskie`
* `~/.config/hypr/scripts/sleepmanager.sh`

---

## 📚 Default Programs

* Terminal: `kitty`
* Launcher: `~/.config/rofi/launcher.sh`
* File Manager: `thunar`
* Browser: `zen-browser`
* Power Menu: `wlogout`
* Code Editor: `code`

---

## 🪟 Window Rules & Workspaces

* Workspace 1 → zen
* Workspace 2 → Code / Zed / Godot / Blender
* Workspace 3 → VLC
* Workspace 4 → virt-manager
* Workspace 5 → Heroic / Steam

**Floating / Size / Opacity Rules:**

* `kitty`, `thunar`, `pavucontrol` → floating
* `thunar` → 1600x900
* `pavucontrol` → 1280x600
* `blender`, `Godot`, `rofi` → opacity 1 override
* `Code` → opacity 0.9 override
* `blender`, `heroic`, `steam`, `virt-manager`, `Godot` → fullscreen
* `steam_app_0`, `virt-manager`, `Code` → opacity 1
* `rofi` → immediate
* xwayland:1 → noblur

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
* Gaming Mode toggle with mainMod+F1
* Floating rules and opacity per window
* Smooth animations with Bézier curves
* Blur & shadows for depth
* NVIDIA and VM-ready environment

---

## 📚 Learn More

* 🧪 Hyprland Wiki → [https://wiki.hyprland.org](https://wiki.hyprland.org)

```
