#!/system/bin/sh
# 🤖 Android LUKS Mounter Service Script

# Wait for boot to settle
sleep 15

# Global paths are already handled by the mounter script itself,
# so we can just call it with --all.
# The script will run its own internal polling if needed, but for modules,
# it's better to just trigger it once or run a simple loop here.

while true; do
    /system/bin/mounter --all >> /data/local/tmp/mounter.log 2>&1
    sleep 10
done
