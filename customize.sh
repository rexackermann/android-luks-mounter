# 🚀 Android LUKS Mounter Installer
# 👤 Author: Rex Ackermann
# 📝 Purpose: Magisk/KernelSU Module Installer Script.
#    Verified to work with standard Magisk/KSU implementation.

# --- ✨ Installer Aesthetics ---
# Define standard ANSI color codes for terminal output.
# Note: ui_print supports some of these depending on the manager.
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color (Reset)

# Print header banner
ui_print " "
ui_print "################################################"
ui_print "#                                              #"
ui_print "#   🚀 ANDROID LUKS MOUNTER - INSTALLER        #"
ui_print "#                                              #"
ui_print "#   👤 Author: Rex Ackermann                   #"
ui_print "#   🌐 GitHub: github.com/rexackermann         #"
ui_print "#                                              #"
ui_print "################################################"
ui_print " "

# --- 🔍 Dependency Check ---
ui_print "[*] Verifying critical dependencies..."

# Path Discovery:
# We need to explicitly check Termux paths because the installer
# runs in a restricted storage context.
TERMUX_PREFIX="/data/data/com.termux/files/usr"
# Export PATH to include standard Android binaries AND Termux binaries.
export PATH="$PATH:$TERMUX_PREFIX/bin:/sbin:/system/sbin:/system/bin:/system/xbin:/data/local/bin"
# Export LD_LIBRARY_PATH so binaries can find their .so files.
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$TERMUX_PREFIX/lib"

MISSING_DEPS=""

# Function: check_dep
# Usage: check_dep <binary_name>
# Checks if a binary exists in the current PATH.
check_dep() {
    # command -v is a POSIX compliant way to check for executables.
    if ! command -v "$1" >/dev/null 2>&1; then
        MISSING_DEPS="$MISSING_DEPS $1" # Append missing tool to list
        return 1
    fi
    return 0
}

# Verify essential tools required for functionality.
check_dep cryptsetup || ui_print "  [!] Warning: cryptsetup missing!"
check_dep bindfs || ui_print "  [!] Warning: bindfs missing!"
check_dep blkid || ui_print "  [!] Warning: blkid missing!"
check_dep nsenter || ui_print "  [!] Warning: nsenter missing!"

# If any dependencies are missing, abort installation to prevent broken state.
if [ -n "$MISSING_DEPS" ]; then
    ui_print " "
    ui_print "🚨 CRITICAL: Missing required tools!"
    ui_print "------------------------------------------------"
    ui_print "To use this module, you MUST install dependencies"
    ui_print "inside Termux first:"
    ui_print " "
    ui_print "  1. Open Termux"
    ui_print "  2. Run: pkg update && pkg upgrade"
    ui_print "  3. Run: pkg install cryptsetup bindfs"
    ui_print "------------------------------------------------"
    ui_print " "
    # 'abort' is a Magisk function that stops the flash process.
    abort "❌ Installation failed due to missing dependencies."
fi

ui_print "✅ All dependencies found! ✨"
ui_print "[*] Extracting module files..."

# 🏷️ Version Reporting
# Extract 'Version: v...' from the script header to show user.
# Use sed to safely capture "v..." until the trailing space/hash.
VERSION_MATCH=$(grep "Version:" "$MODPATH/system/bin/mounter" | head -n 1)
INSTALLED_VER=$(echo "$VERSION_MATCH" | sed -n 's/.*Version: \(v[0-9.]*-[A-Z0-9-]*\).*/\1/p')

ui_print " "
ui_print "📦 Installing Mounter Version: ${INSTALLED_VER:-v1.5.x-UNKNOWN}"
ui_print " "

# --- 🏗️ Setup Permissions ---
# Function: set_permissions
# Sets file ownership and execute bits.
set_permissions() {
  # Recursive: User 0, Group 0, Dir 755, File 644
  set_perm_recursive $MODPATH 0 0 0755 0644
  
  # Explicit: Executables
  set_perm $MODPATH/system/bin/mounter 0 0 0755
  set_perm $MODPATH/service.sh 0 0 0755
  set_perm $MODPATH/action.sh 0 0 0755
  set_perm $MODPATH/customize.sh 0 0 0755
}

# ⚡ Call set_permissions to apply the rules.
set_permissions

ui_print "[+] Installation complete! 🎊"
ui_print " "
ui_print "💡 Tips:"
ui_print " - Look for the 'Action' button in your SU Manager."
ui_print " - Use 'mounter --help' in terminal for details."
ui_print " "
