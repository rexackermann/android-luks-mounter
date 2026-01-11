#!/bin/bash
# 🛠️ Android LUKS Mounter - Module Builder
# 👤 Author: Rex Ackermann

# --- Configuration ---
OUTPUT_ZIP="mounter-module.zip"

# --- 🚀 Build Process ---
echo "[*] Starting build for Android LUKS Mounter..."

# 1. Cleanup
if [ -f "$OUTPUT_ZIP" ]; then
    echo "[+] Removing old build..."
    rm "$OUTPUT_ZIP"
fi

# 2. Packaging
echo "[+] Creating flashable ZIP: $OUTPUT_ZIP"
# We exclude the build script itself and repo metadata/tracking files from the ZIP.
zip -r9 "$OUTPUT_ZIP" module.prop customize.sh service.sh action.sh system/ LICENSE README.md -x ".*"

# 3. Success
if [ -f "$OUTPUT_ZIP" ]; then
    echo " "
    echo "################################################"
    echo "#                                              #"
    echo "#   ✅ BUILD SUCCESSFUL!                       #"
    echo "#   📁 Output: $OUTPUT_ZIP                #"
    echo "#                                              #"
    echo "################################################"
else
    echo "❌ Build failed!"
    exit 1
fi
