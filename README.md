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
- **🪄 Dynamic Skeleton**: Automatically "blesses" mount points at boot for perfect permissions.
- **🛡️ Safety Checks**: Intelligent protection against accidental mounting of system partitions.
- **📦 Flashable Module**: One-click installation for KernelSU, APatch, and Magisk.

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

## 🚀 Installation

### Option 1: Flashable Module (Recommended)
1. Download the latest `android-luks-mounter-vX.X.X.zip` from the [Releases](https://github.com/rexackermann/android-luks-mounter/releases).
2. Flash it in your SU Manager (KernelSU, APatch, or Magisk).
3. **Reboot**. This is required for the Dynamic Skeleton to initialize.

---

## 📖 How to Use

### 📁 Automatic Mode (Plug & Play)
Once installed and rebooted, simply plug in your drive. The background service will:
1. Detect the drive within 5 seconds.
2. Auto-unlock it if a key exists in `/data/adb/mounter/`.
3. Mount it to your configured path (default: `/sdcard/ext/label`).

### ⌨️ CLI Mode
Open Termux and run:
- `mounter --status` : See current mount status and connected drives.
- `mounter /dev/block/sda1 MyDrive` : Mount a specific device manually.
- `mounter -u MyDrive` : Safely unmount a drive by its label.

---

## ⚙️ Configuration
Your settings live at `/data/adb/mounter/config`.

### **Custom Mount Points**
You can change where a drive appears by editing the `STORAGE_PATH` for its UUID:
```bash
STORAGE_PATH_abc_123="/storage/emulated/0/MyCustomFolder"
```
> [!TIP]
> After changing a path in the config, **REBOOT ONCE**. The "Dynamic Skeleton" logic will detect the new path and ensure it has the correct permissions for Android apps to write to it.

---

## ❓ FAQ & Troubleshooting

### **Q: My file manager says the drive is Read-Only!**
**A:** This is usually because the "Magic Mount" trick didn't run. 
1. Ensure you have **rebooted** at least once after installation.
2. Check if your path is inside your internal storage (e.g., `/sdcard/something`).
3. Check the logs: `cat /data/local/tmp/mounter.log`.

### **Q: Why are my folders owned by `root` or `media_rw`?**
**A:** This is intentional! Android's security layer blocks write access to files owned by regular users in shared storage. By using the `media_rw` (1023) group and the "Magic Mount" trick, we bypass these restrictions so that **all** apps can read and write to your drive.

### **Q: How do I add an auto-unlock key?**
**A:** Mount the drive once using a password. The script will ask if you want to generate a keyfile. If you say `y`, it will create a secure key in `/data/adb/mounter/` for future use.

---

## ⚖️ License
Released under the **MIT License**. See `LICENSE` for details.

---
*Created with ❤️ by [Rex Ackermann](https://github.com/rexackermann)*
