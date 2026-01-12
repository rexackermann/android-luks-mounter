#!/system/bin/sh
# 🪄 Magic Mount Skeleton Creator
# Purpose: Pre-create mount point directories with correct permissions
#          BEFORE Android's storage layer initializes.
# 
# This runs during Magisk's early boot phase to establish the directory
# structure. The actual filesystem mounting happens later via service.sh.

MODDIR=${0%/*}
MOUNT_BASE="/storage/emulated/0/ext"

# Wait for storage to be ready
sleep 5

# Create the base mount directory if it doesn't exist
if [ ! -d "$MOUNT_BASE" ]; then
    mkdir -p "$MOUNT_BASE"
    
    # Set permissions to match Android's media folders
    # Owner: root (system)
    # Group: media_rw (1023)
    # Perms: 2770 (rwxrws---) with setgid
    chown root:1023 "$MOUNT_BASE"
    chmod 2770 "$MOUNT_BASE"
fi

# Log success
echo "[$(date)] Magic mount skeleton created: $MOUNT_BASE" >> /data/local/tmp/mounter.log
