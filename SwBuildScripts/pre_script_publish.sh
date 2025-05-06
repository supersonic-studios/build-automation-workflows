#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

echo "[Pre-Build Script] Start of pre-build hook."

# Path to the ProjectSettings.asset file
PROJECT_SETTINGS_PATH="./ProjectSettings/ProjectSettings.asset"

# Default version code if the environment variable is not set
VERSION_CODE="${VERSION_CODE:-101}"

echo "[Pre-Build Script] Using Version Code: $VERSION_CODE"

# Check if the ProjectSettings.asset file exists
if [[ -f "$PROJECT_SETTINGS_PATH" ]]; then
    echo "[Pre-Build Script] Found ProjectSettings.asset. Updating bundleVersionCode..."

    # Cross-platform sed command
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # For MacOS (BSD sed)
        sed -i '' "s/bundleVersionCode: [0-9]*/bundleVersionCode: $VERSION_CODE/" "$PROJECT_SETTINGS_PATH"
    else
        # For Linux/GNU sed
        sed -i "s/bundleVersionCode: [0-9]*/bundleVersionCode: $VERSION_CODE/" "$PROJECT_SETTINGS_PATH"
    fi 

    echo "[Pre-Build Script] Successfully updated bundleVersionCode to $VERSION_CODE."

else
    echo "[Pre-Build Script] ERROR: ProjectSettings.asset file not found at $PROJECT_SETTINGS_PATH. Exiting."
    exit 1
fi

echo "[Pre-Build Script] Completed pre-build hook."
