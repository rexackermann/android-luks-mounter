#!/system/bin/sh
# 🤖 Android LUKS Mounter Service Script
# 👤 Author: Rex Ackermann
# 📝 Purpose: This script runs as a background service (daemon) to automatically
#    detect and mount drives when they are plugged in.

# --- ⏳ Boot Wait Loop ---
# Wait for the Android boot process to settle and for the user to unlock the screen.
# Significance:
# 1. On File-Based Encryption (FBE) devices (modern Android), the /sdcard partition
#    and many encrypted storage areas are NOT accessible until the user enters their PIN/Pattern.
# 2. Waiting for /sdcard/Android ensures the storage framework is fully initialized.
until [ -d "/sdcard/Android" ]; do
  sleep 1 # re-check every second
done

# --- 🚀 Main Service Loop ---
# Global paths (PATH, LD_LIBRARY_PATH) are verified and set by the mounter script itself.
# We call the main script with the '--all' flag to trigger a full scan-and-mount pass.

while true; do
    # 📏 Log Management:
    # We divert output to a log file for debugging.
    LOG_FILE="/data/local/tmp/mounter.log"
    
    # 🧹 Auto-Rotation:
    # To prevent the log file from consuming all available space in /data/local/tmp,
    # we check its size. If it exceeds 10,000 lines, we truncate it.
    if [ -f "$LOG_FILE" ] && [ "$(wc -l < "$LOG_FILE")" -gt 10000 ]; then
        # Keep the last 10,000 lines (most recent) and discard the rest.
        tail -n 10000 "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
    fi

    # ⚡ Execute the Mount Scan:
    # 1. Calls /system/bin/mounter
    # 2. '--all' flag tells it to scan all block devices and mount any known/configured ones.
    # 3. '>> "$LOG_FILE" 2>&1' captures both Standard Output and Errors to the log.
    /system/bin/mounter --all >> "$LOG_FILE" 2>&1
    
    # ⏱️ Polling Interval:
    # Wait 10 seconds before scanning again.
    # This balance ensures drives are picked up relatively quickly without burning CPU.
    sleep 10
done
