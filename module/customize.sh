# 🚀 Android LUKS Mounter Installer
# 👤 Author: Rex Ackermann

# --- ✨ Installer Aesthetics ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

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

# Path Discovery (Same logic as script for installer check)
TERMUX_PREFIX="/data/data/com.termux/files/usr"
export PATH="$PATH:$TERMUX_PREFIX/bin:/sbin:/system/sbin:/system/bin:/system/xbin:/data/local/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$TERMUX_PREFIX/lib"

MISSING_DEPS=""

check_dep() {
    if ! command -v "$1" >/dev/null 2>&1; then
        MISSING_DEPS="$MISSING_DEPS $1"
        return 1
    fi
    return 0
}

check_dep cryptsetup || ui_print "  [!] Warning: cryptsetup missing!"
check_dep bindfs || ui_print "  [!] Warning: bindfs missing!"
check_dep blkid || ui_print "  [!] Warning: blkid missing!"
check_dep nsenter || ui_print "  [!] Warning: nsenter missing!"

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
    abort "❌ Installation failed due to missing dependencies."
fi

ui_print "✅ All dependencies found! ✨"
ui_print "[*] Extracting module files..."

# --- 🏗️ Setup Permissions ---
set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm $MODPATH/system/bin/mounter 0 0 0755
}

ui_print "[+] Installation complete! 🎊"
ui_print " "
ui_print "💡 Tips:"
ui_print " - Look for the 'Action' button in your SU Manager."
ui_print " - Use 'mounter --help' in terminal for details."
ui_print " "
