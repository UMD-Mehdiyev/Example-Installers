#!/bin/bash

# Define variables
APP_NAME="Example Installer"
DMG_NAME="example-installer-1.0-mac.dmg"
VOLUME_NAME="Example Installer"
APP_FOLDER="example-installer-1.0-mac"

# Create a temporary directory to stage the files
STAGING_DIR="staging"
mkdir -p "$STAGING_DIR/$APP_FOLDER"

# Copy the executable and license into the staging directory
cp ./app "$STAGING_DIR/$APP_FOLDER/"
cp ../LICENSE.txt "$STAGING_DIR/$APP_FOLDER/"
ln -s /Applications "$STAGING_DIR/Applications"

# Create the .dmg file
hdiutil create \
  -volname "$VOLUME_NAME" \
  -srcfolder "$STAGING_DIR" \
  -ov \
  -format UDZO \
  "$DMG_NAME"

# Clean up the staging directory
rm -rf "$STAGING_DIR"

echo "macOS installer created: $DMG_NAME"
