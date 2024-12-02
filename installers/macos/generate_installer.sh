#!/bin/bash

# Create the directory structure for the .pkg package
mkdir -p pkg-root/Applications

# Copy the executable and license to ~/Applications
cp ./app pkg-root/Applications/
cp ../LICENSE.txt pkg-root/Applications/

# Build the .pkg package
pkgbuild --root pkg-root \
    --identifier com.example.installer \
    --version 1.0 \
    --install-location /Applications \
    example-installer-1.0-mac.pkg

# Clean up
rm -rf pkg-root

echo "macOS installer created: example-installer-1.0-mac.pkg"
