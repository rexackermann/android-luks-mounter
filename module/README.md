# 🚀 Android LUKS Mounter ✨

Professional storage management for **LUKS-encrypted** and **plain** drives on Android. This project provides a robust shell script and a flashable module (KernelSU / APatch / Magisk) to seamlessly integrate external storage into your Android ecosystem.

Authored with ❤️ by **Rex Ackermann**.

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

## 🚀 Installation

### Option 1: Flashable Module (Recommended)
1. Download the latest `mounter-module.zip` from the Releases page.
2. Flash it via **KernelSU**, **APatch**, or **Magisk**.
3. **Reboot** and enjoy!

### Option 2: Manual (Termux)
1. Clone the repository: `git clone https://github.com/rexackermann/android-mounter`
2. Install dependencies: `pkg install cryptsetup bindfs`
3. Link the binary: `sudo ./mounter.sh --link-bin`
4. Run: `mounter --help`

---

## 🛠️ Usage

### 📂 Manual Mount
```bash
sudo mounter /dev/block/sda1 MyDrive
```

### ⚡ Auto-Mount Everything
```bash
sudo mounter --all
```

### 🔄 Sync & Update Config
```bash
sudo mounter --auto-update-config
```

---

## 💡 Developer & Author
- **Author**: Rex Ackermann
- **GitHub**: [@rexackermann](https://github.com/rexackermann)

---

## ⚖️ License
Released under the **MIT License**. See `LICENSE` for details.
