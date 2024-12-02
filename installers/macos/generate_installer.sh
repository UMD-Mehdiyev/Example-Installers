#!/bin/bash

# Define variables
APP_NAME="Example Installer.app" # Name of your application as it will appear in the DMG
DMG_NAME="example-installer-1.0-mac.dmg" # Name of the output DMG file
VOLUME_NAME="Example Installer" # Name of the DMG volume when mounted
STAGING_DIR="staging" # Temporary directory for DMG content

# Create the staging directory
mkdir -p "$STAGING_DIR/$APP_NAME"

# Copy your application and license file into the staging directory
cp ./app "$STAGING_DIR/$APP_NAME/" # Replace ./app with your actual app bundle or executable
cp ../LICENSE.txt "$STAGING_DIR/$APP_NAME/"

# Create a symbolic link to the Applications folder in the staging directory
ln -s /Applications "$STAGING_DIR/Applications"

# Create the DMG file with drag-and-drop functionality
hdiutil create \
  -volname "$VOLUME_NAME" \
  -srcfolder "$STAGING_DIR" \
  -ov \
  -format UDZO \
  "$DMG_NAME"

# Clean up the staging directory
rm -rf "$STAGING_DIR"

echo "macOS installer created: $DMG_NAME"
