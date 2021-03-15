#!/bin/bash

# GET XCODE PROJECT (OR WORKSPACE) PATH, SCHEME, AND OUTPUT LOCATION
PROJECT="Auto"
SCHEME="Auto"
OUTPUT_LOCATION="veracode"

# CLEAN OUTPUT FOLDER
rm -rf "$OUTPUT_LOCATION" 
mkdir "$OUTPUT_LOCATION"

xcodebuild archive \
	-project "Auto.xcodeproj" \
	-scheme "Auto" \
	-archivePath "Auto.xcodeproj" \
	-destination "generic/platform=iOS" \
	-allowProvisioningUpdates \
	DEBUG_INFORMATION_FORMAT=dwarf-with-dsym \
	ENABLE_BITCODE=YES

# MOVE APPLICATIONS DIRECTORY OUT OF PRODUCTS AND UP TO PARENT
mv ${PROJECT}.xcarchive/Products/Applications/ ${PROJECT}.xcarchive/Payload/

# REMOVE THE PRODUCTS DIRECTORY
rmdir ${PROJECT}.xcarchive/Products/

# ZIP ALL FILES IN XCODE ARCHIVE
cd ${PROJECT}.xcarchive
zip -r ${OUTPUT_LOCATION}/${PROJECT}.bca $(ls)

# REMOVE ARCHIVE
rm -rf "Auto.xcodeproj.xcarchive"

echo ""
echo "Directory listing: "
ls
