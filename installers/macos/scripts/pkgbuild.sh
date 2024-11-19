#!/bin/bash
# Script to build a macOS .pkg installer

APP_EXECUTABLE=$1
LICENSE_FILE=$2
OUTPUT_PKG=$3

if [[ -z "$APP_EXECUTABLE" || -z "$LICENSE_FILE" || -z "$OUTPUT_PKG" ]]; then
    echo "[ERROR] Missing arguments. Usage: pkgbuild.sh <executable> <license> <output.pkg>"
    exit 1
fi

# Ensure pkgbuild is installed
if ! command -v pkgbuild &>/dev/null; then
    echo "[ERROR] pkgbuild is not installed. Install it and try again."
    exit 1
fi

# Prepare build directory
BUILD_DIR="build_pkg"
mkdir -p "$BUILD_DIR/usr/local/bin"
mkdir -p "$BUILD_DIR/usr/share/licenses/example-installer"

echo "[INFO] Copying files to build directory..."
cp "$APP_EXECUTABLE" "$BUILD_DIR/usr/local/bin/example-installer"
cp "$LICENSE_FILE" "$BUILD_DIR/usr/share/licenses/example-installer/LICENSE.txt"

# Create the .pkg installer
echo "[INFO] Building macOS .pkg installer..."
pkgbuild --root "$BUILD_DIR" \
    --identifier "com.example.installer" \
    --version "1.0" \
    --install-location "/" \
    "$OUTPUT_PKG"

# Clean up temporary files
rm -rf "$BUILD_DIR"
echo "[INFO] macOS installer created at $OUTPUT_PKG"
