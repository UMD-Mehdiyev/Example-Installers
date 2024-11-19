#!/bin/bash
# Script to build a .deb installer for Linux

APP_EXECUTABLE=$1
LICENSE_FILE=$2
OUTPUT_DEB=$3

if [[ -z "$APP_EXECUTABLE" || -z "$LICENSE_FILE" || -z "$OUTPUT_DEB" ]]; then
    echo "[ERROR] Missing arguments. Usage: deb-build.sh <executable> <license> <output.deb>"
    exit 1
fi

# Check if dpkg-deb is installed
if ! command -v dpkg-deb &>/dev/null; then
    echo "[ERROR] dpkg-deb is not installed. Install it and try again."
    exit 1
fi

# Prepare the directory structure for the .deb package
DEB_DIR="example_installer_deb"
mkdir -p "$DEB_DIR/DEBIAN"
mkdir -p "$DEB_DIR/usr/local/bin"
mkdir -p "$DEB_DIR/usr/share/licenses/example-installer"

# Copy the executable and license file to their respective locations
echo "[INFO] Copying files..."
cp "$APP_EXECUTABLE" "$DEB_DIR/usr/local/bin/example-installer"
cp "$LICENSE_FILE" "$DEB_DIR/usr/share/licenses/example-installer/LICENSE.txt"

# Create the control file
echo "[INFO] Creating control file..."
cat > "$DEB_DIR/DEBIAN/control" <<EOL
Package: example-installer
Version: 1.0
Section: utils
Priority: optional
Architecture: all
Depends: 
Maintainer: Your Name <your.email@example.com>
Description: Example Installer
 A simple example installer for demonstration purposes.
EOL

# Build the .deb package
echo "[INFO] Building .deb package..."
dpkg-deb --build "$DEB_DIR" "$OUTPUT_DEB"

# Clean up
echo "[INFO] Cleaning up..."
rm -rf "$DEB_DIR"

echo "[INFO] .deb package created at $OUTPUT_DEB"
