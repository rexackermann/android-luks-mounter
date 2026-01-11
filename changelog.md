# Changelog

## v1.5.0-OPTIMIZED
- **🏗️ Repository Restructure**: Flattened the repo to eliminate file duplication; the repository root is now the Magisk module source.
- **🔑 Custom Key Mapping**: Support for `KEY_PATH_${safe_uuid}` in the config to link specific keyfiles (including those without `.key` extension).
- **🚀 Discovery Optimization**: Improved the automatic key lookup to gracefully handle non-standard filenames like 'al'.
- **🛠️ Build Refresh**: Updated `build.sh` to correctly package the new root-based structure.

## v1.4.3-ULTIMATE
- Fixed nsenter argument parsing with absolute paths and flag separation.
- Implemented a Binary Registry log for deterministic tool discovery.
- Enhanced Su Manager compatibility (KernelSU/Suki) with version code bumping.
- Fixed FBE unlock detection for reliable boot mounting.
