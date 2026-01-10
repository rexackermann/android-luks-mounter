#!/bin/bash
# 🛠️ Android LUKS Mounter - Module Builder
# 👤 Author: Rex Ackermann

# --- Configuration ---
MODULE_DIR="module"
OUTPUT_ZIP="mounter-module.zip"

# --- 🚀 Build Process ---
echo "[*] Starting build for Android LUKS Mounter..."

# 1. Verification
if [ ! -d "$MODULE_DIR" ]; then
    echo "Error: Module directory not found!"
    exit 1
fi

# 2. Cleanup
if [ -f "$OUTPUT_ZIP" ]; then
    echo "[+] Removing old build..."
    rm "$OUTPUT_ZIP"
fi

# 3. Packaging
echo "[+] Creating flashable ZIP: $OUTPUT_ZIP"
cd "$MODULE_DIR"
zip -r9 "../$OUTPUT_ZIP" ./* -x ".*"
cd ..

# 4. Success
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
