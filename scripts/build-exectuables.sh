#!/bin/bash

# Script to generate standalone executables with PyInstaller for each platform
# Ensure PyInstaller is installed: `pip install pyinstaller`
# Usage: Run this script on the target platform to build the corresponding executable.

APP_NAME="main.py"        # Name of your Python app file
APP_DIR="../app"          # Relative path to the app directory
OUTPUT_DIR="../dist"      # Output directory for executables
APP_OUTPUT_NAME="Example-Installers"  # Desired name for the executable
RESOURCE_DIR="assets"     # Directory containing additional resources (e.g., images)

# Detect the platform and set the separator for --add-data
if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
    DATA_SEPARATOR=":"  # Use colon on Linux/macOS
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win32" ]]; then
    DATA_SEPARATOR=";"  # Use semicolon on Windows
else
    echo "Unsupported platform: $OSTYPE"
    exit 1
fi

# Function to display a message
function log_message() {
    echo "[INFO] $1"
}

log_message "Starting build process for ${APP_NAME} on platform $OSTYPE..."

# Navigate to the app directory
cd "$APP_DIR" || { echo "App directory not found! Exiting."; exit 1; }

# Clean up any previous builds
log_message "Cleaning up previous builds..."
rm -rf build dist
rm -f "${APP_NAME%.py}.spec"  # Remove any old spec files in the current directory

# Run PyInstaller with the platform-specific --add-data separator
log_message "Building standalone executable..."
pyinstaller --name "${APP_OUTPUT_NAME}" --onefile \
    --add-data "${RESOURCE_DIR}/me.png${DATA_SEPARATOR}assets" \
    "$APP_NAME"

# Move the output to the designated folder
log_message "Organizing output..."
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi
mv dist/* "$OUTPUT_DIR/"

# Clean up intermediate files and leftover .spec files
log_message "Cleaning up intermediate files..."
rm -rf build dist
rm -f "${APP_NAME%.py}.spec"  # Double-check and remove any lingering spec files

# Final message
log_message "Build process complete! Executables can be found in ${OUTPUT_DIR}/"
