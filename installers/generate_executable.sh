#!/bin/bash

# Detect the operating system
os_type=$(uname)

# Determine the output filename and target folder based on OS
if [[ "$os_type" == "Linux" ]]; then
    target_folder="linux"
    output_file="app"
elif [[ "$os_type" == "Darwin" ]]; then
    target_folder="macos"
    output_file="app"
elif [[ "$os_type" =~ MINGW.* || "$os_type" =~ CYGWIN.* ]]; then
    target_folder="windows"
    output_file="app.exe"
else
    echo "Unsupported operating system: $os_type"
    exit 1
fi

# Run PyInstaller
pyinstaller --onefile --console ../app.py

# Check if PyInstaller succeeded
if [[ $? -ne 0 ]]; then
    echo "PyInstaller failed to create the executable."
    exit 1
fi

# Move the generated file to the target folder
mv dist/$output_file $target_folder/

# Clean up generated files
rm -rf app.spec build dist

# Confirm success
echo "Executable has been moved to the '$target_folder' folder and cleanup is complete."
