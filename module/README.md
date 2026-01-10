# 🚀 Android LUKS Mounter ✨

Professional storage management for **LUKS-encrypted** and **plain** drives on Android. This project brings desktop-class security and advanced mounting features to your mobile device, supporting hotplugging, auto-unlocking, and seamless app integration.

Authored with ❤️ by **Rex Ackermann**.

---

## 👤 Author Information
- **Author**: Rex Ackermann
- **GitHub**: [@rexackermann](https://github.com/rexackermann) 🌐

---

## 🌟 Key Features
- **🔓 LUKS Support**: Real-time unlocking and mounting of encrypted volumes.
- **📁 Filesystem Versatility**: Supports NTFS, ExFAT, BTRFS, F2FS, VFAT, and more.
- **⚡ Auto-Mounting**: Automatically detects and mounts connected OTG and SD cards.
- **🤖 Background Daemon**: Persistent polling service to handle hotplugging effortlessly.
- **🎨 Sexy CLI**: Colorized logs, emojis, and a professional user interface.
- **📦 Flashable Module**: One-click installation for KernelSU, APatch, and Magisk.
- **🛡️ Safety Checks**: Intelligent protection against accidental mounting of system partitions.

---

## 🛠️ Prerequisites & Requirements
> [!IMPORTANT]
> **Dependencies are mandatory for ALL installation methods!** Even if you use the flashable module, you must install the core tools in Termux.

1. **🔑 Root Access**: Required for low-level block device operations (KernelSU, APatch, or Magisk).
2. **📟 Termux Environment**: The engine that provides necessary libraries.
3. **📦 Terminal Dependencies**:
   Open Termux and run:
   ```bash
   pkg update && pkg upgrade
   pkg install cryptsetup bindfs
   ```

---

## 🚀 Installation Options

### Option 1: Flashable Module (KernelSU / APatch / Magisk)
*Best for persistence and easy management.*
1. Download `mounter-module.zip` from the Releases page.
2. Flash it in your SU Manager.
3. **Reboot**. The script is now globally available and auto-runs on boot.

### Option 2: Manual Setup
*Best for quick tests or custom environments.*
1. Clone the repo: `git clone https://github.com/rexackermann/android-luks-mounter`
2. Link the binary: `cd android-luks-mounter && sudo ./module/system/bin/mounter --link-bin`
3. You can now use the `mounter` command anywhere.

---

## 📖 How to Use Like a Pro

### 1. 🔍 Discovery
Connect your drive and find its path:
```bash
ls /dev/block/sd*  # Usually /dev/block/sda1 for OTG drives
```

### 2. 📂 Manual Mount
Mount a partition with a custom label:
```bash
sudo mounter /dev/block/sda1 MyVault
```

### 3. 🔓 Unlocking & Key Management
- **Auto-Unlock**: If a keyfile exists in your `luks_keys` directory, the script uses it!
- **Interactive**: The script will prompt for a password or custom key if needed.
- **💾 Auto-Unlock Setup**: After unlocking with a password, the script will offer to create a keyfile for instant access in the future.

---

## ⚡ Power User Features

### 🔄 Auto-Update & Sync
Sync your configuration with current hardware and mount everything in one command:
```bash
sudo mounter --auto-update-config
```

### 📡 Smart Scanning
Register your drives without mounting (updates labels in config):
```bash
sudo mounter --scan
```

### 🤖 Automatic Service
Install the background daemon to handle storage hotplugging automatically:
```bash
sudo mounter --install-service
```

---

## � Pro-Tips & Troubleshooting

## 💡 Pro-Tips & Troubleshooting
- **🎨 Visuals**: The script uses ANSI colors. If logs look messy, ensure your terminal supports color.
- **📂 Custom Paths**: edit the `config` file in your keys directory to override mount locations.
- **⚠️ Unmounting**: Always use `mounter -u Label` before unplugging!
- **🛠️ Missing Tools?**: If `mounter` fails to find `cryptsetup`, ensure you've run the `pkg install` commands in Termux!

---

## ⚖️ License
Released under the **MIT License**. See `LICENSE` for details.

---
*Created with ❤️ by [Rex Ackermann](https://github.com/rexackermann)*
