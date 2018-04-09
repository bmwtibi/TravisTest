#!/bin/sh

security list-keychains -s $IOS_KEYCHAIN_NAME

#rm  ~/Library/MobileDevice/Provisioning\ Profiles/profile.mobileprovision

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles/

cp "./scripts/certs/dev.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
cp "./scripts/certs/adhoc.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/

ls

xcrun xcodebuild -workspace TravisTest.xcworkspace -scheme TravisTest -archivePath TravisTest.xcarchive archive

xcrun xcodebuild -exportArchive -archivePath TravisTest.xcarchive -exportPath . -exportOptionsPlist "./scripts/certs/DevExportOptions.plist"

xcrun xcodebuild -exportArchive -archivePath TravisTest.xcarchive -exportPath . -exportOptionsPlist "./scripts/certs/AdhocExportOptions.plist"