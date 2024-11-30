#!/bin/bash

# Create the directory structure for the .pkg package
mkdir -p pkg-root/usr/local/bin

# Copy the executable and license
cp ./app pkg-root/usr/local/bin/
cp ../LICENSE.txt pkg-root/usr/local/bin/

# Build the .pkg package
pkgbuild --root pkg-root --identifier com.example.installer --version 1.0 --install-location /usr/local/bin example-installer-1.0-mac.pkg

# Clean up
rm -rf pkg-root

echo "macOS installer created: example-installer-1.0-mac.pkg"
