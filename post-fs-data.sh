# 🪄 Dynamic Magic Mount Skeleton Creator
# Purpose: Parse the mounter config and pre-create all custom mount points
#          BEFORE Android's storage layer (FUSE) initializes.
# 
# This ensures that any path specified in the config gets "blessed" permissions
# that Android respects, preventing "read-only" issues.

CONFIG_FILE="/data/media/0/Documents/luks_keys/config"
LOG_FILE="/data/local/tmp/mounter.log"

# Function to "Bless" a directory
bless_dir() {
    local dir="$1"
    [ -z "$dir" ] && return
    
    # Check if the path is within internal storage (sdcard)
    # This is where the FUSE overlay permission issues happen.
    if [[ "$dir" == "/storage/emulated/0"* ]] || [[ "$dir" == "/sdcard"* ]] || [[ "$dir" == "/data/media/0"* ]]; then
        # Map /storage/emulated/0 or /sdcard to /data/media/0 for early boot creation
        local real_dir=$(echo "$dir" | sed -E 's|^(/storage/emulated/0\|/sdcard)|/data/media/0|')
        
        [ ! -d "$real_dir" ] && mkdir -p "$real_dir"
        
        # Always enforce "Blessed" permissions (media_rw:media_rw) 
        # This fixes the issue where the dir exists but has wrong owner/perms
        chown 1023:1023 "$real_dir"
        chmod 2770 "$real_dir"
        
        # Log result
        local result=$(ls -ld "$real_dir")
        echo "[$(date)] Blessed: $dir -> $result" >> "$LOG_FILE"
    else
        echo "[$(date)] Skipped (Not Internal Storage): $dir" >> "$LOG_FILE"
    fi
}

# 1. Always bless the default base
bless_dir "/storage/emulated/0/ext"

# 2. Parse config for custom STORAGE_PATH entries
if [ -f "$CONFIG_FILE" ]; then
    # Extract values from lines like: STORAGE_PATH_...="/path/to/mount"
    grep "STORAGE_PATH_" "$CONFIG_FILE" | cut -d'"' -f2 | while read -r custom_path; do
        bless_dir "$custom_path"
    done
fi

echo "[$(date)] Dynamic skeleton creation complete. ✨" >> "$LOG_FILE"
