─────────────────────────────────────────────  
**ER QuickSave HK – v1.0**  
Created by [mdotstrange](https://www.nexusmods.com/users) (NexusMods)  
─────────────────────────────────────────────

A lightweight hotkey utility for offline solo Elden Ring players.  
No mod manager required. No configuration files.  
Just press **F5** to back up your progress—or **F9** to restore and relaunch.

---

### 🛠 HOW IT WORKS

ER QuickSave HK doesn’t interfere with Elden Ring’s timing—it watches quietly until your save file stabilizes, then safely duplicates it.

**F5** creates two backups:  
• One timestamped  
• One named **PreDeath** for instant restore

**F9** restores the **PreDeath** save:  
• Closes Elden Ring if it's running  
• Injects the backed-up save file  
• Relaunches the game via Steam

💡 How it keeps your saves clean:  
• Auto-detects your save path using Steam ID folder  
• Monitors file stability to avoid mid-save corruption  
• Copies only when idle—no timers, overlays, or in-game hooks

📦 Backups are stored here:  
`[folder where this app lives]\EldenRingBackups\`

---

### 🧪 INSTALLATION

1. Extract this folder anywhere (e.g. Desktop or Documents)  
2. Run `ERQuickSaveHK.exe`  
3. Launch Elden Ring and press **F5** / **F9** as needed

→ No mod manager required  
→ Auto-detects your save folder  
→ Works offline with solo play

---

### 🔄 OPTIONAL: RUN ON STARTUP

Want ER QuickSave HK to auto-launch with Windows?

1. Press `Win + R`, then type: `shell:startup`  
2. Drop a shortcut to `ERQuickSaveHK.exe` in that folder  

To disable, simply remove the shortcut.

---

### 📁 INCLUDED FILES

- `ERQuickSaveHK.exe`      ← compiled utility  
- `ERQuickSaveHK.ahk`      ← readable source code  
- `readme.txt`             ← usage and license info  
- `EldenRingIcon.ico`      ← tray icon  
- `EldenRingBackups\`      ← auto-created on first use

---

### 🧔 AUTHOR’S NOTE

I’m not a modder and don’t plan to become one. This is the first—and very likely the last—mod I’ll release on NexusMods.

I built ER QuickSave HK because I wanted a dead-simple way to safeguard my Elden Ring progress without relying on overlays, save editors, or game hooks.

The AutoHotkey code was written with help from Microsoft Copilot, but every feature, retry loop, and logic path was chosen by me—through trial, error, 
and the occasional boss-triggered rage quit.

This tool is offered *as-is*. If it breaks, I might fix it. But updates are unlikely unless absolutely necessary.  
Feel free to expand or adapt it—just credit the original.

Thanks for checking it out.

---

### 🎨 ICON CREDIT

Tray icon by [andonovmarko on DeviantArt](https://www.deviantart.com/andonovmarko/art/Elden-Ring-Icon-907331185)  
Used with permission for personal, non-commercial release

---

### 📜 LICENSE & CREDITS

Created by mdotstrange (NexusMods)  
This tool may be modified or extended for personal use.  
If you share a modified version, please credit the original author.

Not affiliated with FromSoftware, Bandai Namco,  
or any third-party mod manager.

---

💾 Glory to the prepared Tarnished.


