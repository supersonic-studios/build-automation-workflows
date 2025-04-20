#!/bin/bash

# Platform-specific publishing logic
if [[ "$BUILD_PLATFORM" == "android" || "$BUILD_PLATFORM" == "androidPlayer" ]]; then
    echo "Starting Post-Build Script for Publishing Android..."

    echo "Setting up Fastlane environment variables..."
    
    # Check if the Base64-encoded JSON is available
    if [[ -z "$GOOGLE_PLAY_JSON_BASE64" ]]; then
        echo "Error: GOOGLE_PLAY_JSON_BASE64 environment variable is not set!"
            exit 1
    fi
        
    # Decode the JSON back to `google-services.json` and save it locally
    GOOGLE_JSON_PATH="$WORKSPACE/google-services.json"
        
    echo "Decoding Base64 Play Store key and saving to: $GOOGLE_JSON_PATH"
    echo "$GOOGLE_PLAY_JSON_BASE64" | base64 --decode > "$GOOGLE_JSON_PATH"
        
    # Check if the file was successfully created
    if [[ ! -f "$GOOGLE_JSON_PATH" ]]; then
      echo "Error: Failed to decode and create google-services.json!"
      exit 1
    else
      echo "Google Play key successfully saved to $GOOGLE_JSON_PATH"
    fi
    
    export GOOGLE_JSON_PATH
    
    # Set app package name (read from `build.json`)
    if [[ -z "$BUNDLE_ID" ]]; then
      BUILD_JSON="$WORKSPACE/build.json"
    
      if [[ -f "$BUILD_JSON" ]]; then
        PACKAGE_NAME=$(cat "$BUILD_JSON" | jq -j '.[].bundleid')
      else
        echo "Error: build.json file not found!"
        exit 1
      fi
    else
      PACKAGE_NAME=${BUNDLE_ID}
    fi

    export PACKAGE_NAME
    # Check if Play Store key exists
    if [[ ! -f "$GOOGLE_JSON_PATH" ]]; then
      echo "Error: Play Store key file not found at $PLAYSTORE_KEY"
      exit 1
    fi
    
    if [[ ! -f "$UNITY_PLAYER_PATH" ]]; then
      echo "Error: Unity build artifact not found at $UNITY_PLAYER_PATH"
      exit 1
    fi
      
      # Trigger Fastlane
      echo "Running Fastlane to upload build to Google Play..."
      cd "$WORKSPACE" # Navigate to the root folder where Fastlane and Fastfile are located
      
      echo "[Post-Build Script] Running Fastlane for Android Play Store upload..."
      fastlane upload_to_internal_track

      # Check result and handle failures
      if [[ $? -eq 0 ]]; then
        echo "[Post-Build Script] Android build successfully uploaded to Google Play Store!"
      else
        echo "[ERROR] Upload to Google Play Store failed!"
        exit 1
      fi
fi

echo "Post-Build Script Completed!"
