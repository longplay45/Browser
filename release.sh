#!/bin/bash

xcodebuild -scheme Browser -configuration Release -derivedDataPath ./derived_data

# subl /Applications/Browser.app/Contents/Resources/urls.txt 

# Path to the derived data directory
DERIVED_DATA_PATH="./derived_data"

# Path to the new build within the derived data directory
NEW_BUILD_PATH="$DERIVED_DATA_PATH/Build/Products/Release/Browser.app"  

# Check if the new build exists
if [ ! -d "$NEW_BUILD_PATH" ]; then
  echo "Error: New build not found at $NEW_BUILD_PATH"
  exit 1
fi

# Remove the old application if it exists
if [ -d "/Applications/Browser.app" ]; then
  echo "Removing old application..."
  rm -rf "/Applications/Browser.app"
fi

# Copy the new build to the Applications directory
echo "Copying new build to /Applications..."
cp -R "$NEW_BUILD_PATH" "/Applications"

echo "Release completed successfully!"


