#!/system/bin/sh
# 🤖 Android LUKS Mounter Service Script

# Wait for boot to settle and user to unlock (FBE)
# On modern Android, /sdcard/ isn't fully accessible until the first unlock.
until [ -d "/sdcard/Android" ]; do
  sleep 1
done

# Global paths are already handled by the mounter script itself,
# so we can just call it with --all.
# The script will run its own internal polling if needed, but for modules,
# it's better to just trigger it once or run a simple loop here.

while true; do
    # 📏 Log Management: Cap the log at 10,000 lines to prevent storage bloat.
    LOG_FILE="/data/local/tmp/mounter.log"
    if [ -f "$LOG_FILE" ] && [ "$(wc -l < "$LOG_FILE")" -gt 10000 ]; then
        # Keep the last 10,000 lines
        tail -n 10000 "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
    fi

    /system/bin/mounter --all >> "$LOG_FILE" 2>&1
    sleep 10
done
