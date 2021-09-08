#!/bin/bash

# You can modify this script to accomodate your project's needs

echo "Starting project setup..."

# Validate Binaries folder
DIR="./Frameworks"
if [ -d "$DIR" ]; then
    echo "Folder already exists, clearing it..."
    rm -rf Frameworks
fi

## Download ZIPs
# FirebaseInstanceID
echo "Downloading Frameworks..."
curl -s \
     --header 'Accept: application/octet-stream' \
     -o Frameworks.zip \
     --location https://api.github.com/repos/crvshlab/public-partner-sdk-example-ios/releases/assets/44299931

## Unzip and Remove
echo "Unziping Frameworks..."
unzip -qq Frameworks.zip
rm -rf Frameworks.zip

# Remove unecessary folder
rm -rf __MACOSX

## Check contents of folder match outcome (only count)
cd Frameworks

COUNT="$(ls | wc -l)"
if [ $COUNT -ne 4 ]; then
    echo "Setup aborted due to Frameworks folder not containing required amount of Frameworks"
    exit 1
fi

## Pod Install
cd ..

echo "Executing pod setup..."
# Check for Podfile
PODFILE_PATH="./Podfile"
if [ -z "$PODFILE_PATH" ]; then
    echo "No Podfile found! Aborting setup..."
    exit 1
fi

# Clear existing pod values, if existing
rm -rf Podfile.lock
rm -rf PartnerIntegration.xcworkspace
rm -rf Pods
pod cache clean --all
pod deintegrate
pod install --repo-update --silent

# Validate success of pod install
WORKSPACE_PATH="./PartnerIntegration.xcworkspace"
PODS_PATH="./Pods"
PODFILE_LOCK_PATH="./Podfile.lock"

if [[ -z "$WORKSPACE_PATH" || -z "$PODS_PATH" || -z "$PODFILE_LOCK_PATH" ]]; then
    echo "Pod setup wasn't succesfull, please check Podfile or run 'pod install' seperatly to see error log..."
else
    echo "Setup completed!"
fi

## Helper: Get Asset IDs
# Example for current release on repo
# curl -s \
# --location https://api.github.com/repos/crvshlab/public-partner-sdk-example-ios/releases/tags/v0.1.2-dependencies.staging
