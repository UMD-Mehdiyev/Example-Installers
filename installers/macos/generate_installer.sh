#!/bin/bash

# Define variables
APP_NAME="example-installer-1.0-mac"  # Name of your app
APP_EXECUTABLE="./app"  # Path to your app executable
LICENSE_FILE="../LICENSE.txt"  # Path to your license file
DMG_NAME="example-installer-1.0-mac.dmg"  # Output DMG file name
DMG_TEMP="temp-dmg"  # Temporary directory for DMG contents

# Step 1: Prepare the .app bundle
mkdir -p "${DMG_TEMP}/${APP_NAME}.app/Contents/MacOS"
mkdir -p "${DMG_TEMP}/${APP_NAME}.app/Contents/Resources"

# Copy executable to the .app bundle
cp "$APP_EXECUTABLE" "${DMG_TEMP}/${APP_NAME}.app/Contents/MacOS/$APP_NAME"
chmod +x "${DMG_TEMP}/${APP_NAME}.app/Contents/MacOS/$APP_NAME"

# Step 2: Add license to the Resources folder
cp "$LICENSE_FILE" "${DMG_TEMP}/${APP_NAME}.app/Contents/Resources/LICENSE.txt"

# Step 3: Add the drag-and-drop functionality
mkdir -p "${DMG_TEMP}/Applications"  # Create a link to the Applications folder
ln -s /Applications "${DMG_TEMP}/Applications"  # Create symbolic link

# Step 4: Create the DMG file
hdiutil create \
  -volname "$APP_NAME Installer" \
  -srcfolder "$DMG_TEMP" \
  -ov -format UDZO "$DMG_NAME"

# Step 5: Clean up
rm -rf "$DMG_TEMP"

echo "DMG created: $DMG_NAME"
