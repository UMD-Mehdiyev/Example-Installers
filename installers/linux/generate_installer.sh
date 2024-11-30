#!/bin/bash

# Create the directory structure for the .deb package
mkdir -p example-installer/DEBIAN
mkdir -p example-installer/usr/local/bin

# Add the control file
cat <<EOL > example-installer/DEBIAN/control
Package: example-installer
Version: 1.0
Architecture: all
Maintainer: CMSC435 Team SEL
Description: Example Installer for Linux
EOL

# Copy the executable and license
cp ./app example-installer/usr/local/bin/
cp ../LICENSE.txt example-installer/usr/local/bin/

# Build the .deb package
dpkg-deb --build example-installer

# Move the .deb package to the current directory
mv example-installer.deb example-installer-1.0-linux.deb

# Clean up
rm -rf example-installer

echo "Linux installer created: example-installer-1.0-linux.deb"
