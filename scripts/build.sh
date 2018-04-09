#!/bin/sh

security list-keychains -s $IOS_KEYCHAIN_NAME

#rm  ~/Library/MobileDevice/Provisioning\ Profiles/profile.mobileprovision
#/Users/tiborgore/Library/MobileDevice/Provisioning Profiles

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles/

#cp "./scripts/certs/dev.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
cp "./scripts/certs/adhoc.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/

ls

xcrun xcodebuild -workspace TravisTest.xcworkspace -scheme TravisTest -archivePath TravisTest.xcarchive archive

#xcrun xcodebuild -exportArchive -archivePath TravisTest.xcarchive -exportPath Ipas/Dev -exportOptionsPlist "./scripts/certs/DevExportOptions.plist"

xcrun xcodebuild -exportArchive -archivePath TravisTest.xcarchive -exportPath Ipas/Adhoc -exportOptionsPlist "./scripts/certs/AdhocExportOptions.plist"


#mv Ipas/Dev/TravisTest.ipa ./TravisTest-Dev.ipa
mv Ipas/Adhoc/TravisTest.ipa ./TravisTest-Adhoc.ipa