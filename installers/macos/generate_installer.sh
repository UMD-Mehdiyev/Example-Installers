#!/bin/bash

# Define the app folder name and package name
NAME="example-installer-1.0-mac.pkg"
=""

# Create the directory structure for the .pkg package
mkdir -p "pkg-root/Applications/$NAME"

# Copy the executable and license to ~/Applications/example-installer-1.0-mac.pkg
cp ./app "pkg-root/Applications/$NAME/"
cp ../LICENSE.txt "pkg-root/Applications/$NAME/"

# Build the .pkg package
pkgbuild --root pkg-root \
    --identifier com.example.installer \
    --version 1.0 \
    --install-location "~/Applications/" \
    "example-installer-1.0-mac.pkg"

# Clean up
rm -rf pkg-root

echo "macOS installer created: example-installer-1.0-mac.pkg"
