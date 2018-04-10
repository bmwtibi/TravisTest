#!/bin/sh

security list-keychains -s $IOS_KEYCHAIN_NAME

#rm  ~/Library/MobileDevice/Provisioning\ Profiles/profile.mobileprovision
#/Users/tiborgore/Library/MobileDevice/Provisioning Profiles

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles/

#cp "./scripts/certs/dev.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
cp "./scripts/certs/adhoc.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/


echo "----------xcodebuild -showBuildSettings-----------"
xcodebuild -showBuildSettings
echo "--------------------------------------------------"

echo "----------No Acrhive-----------"
ls

echo "----------Acrhive Settings-----------"

which rvm > /dev/null
if [[ $? -eq 0 ]]; then
  echo "RVM detected, forcing to use system ruby"
  # This allows you to use rvm in a script. Otherwise you get a BS
  # error along the lines of "cannot use rvm as function". Jeez.
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

  # Cause rvm to use system ruby. AFAIK, this is effective only for
  # the scope of this script.
  rvm use system
fi

if which rbenv > /dev/null; then
  echo "rbenv detected, removing env variables"

  # Cause rbenv to use system ruby. Lasts only for the scope of this
  # session which will normally just be this script.
  rbenv shell system

  unset GEM_HOME
  unset GEM_PATH
fi

# Since Xcode has a dependency to 2 external gems: sqlite and CFPropertyList
# More information https://github.com/fastlane/fastlane/issues/6495
# We have to unset those variables for rbenv, rvm and when the user uses bundler
unset RUBYLIB
unset RUBYOPT
unset BUNDLE_BIN_PATH
unset _ORIGINAL_GEM_PATH
unset BUNDLE_GEMFILE

set -x          # echoes commands





xcrun xcodebuild -workspace TravisTest.xcworkspace -scheme TravisTest -archivePath TravisTest.xcarchive archive

ls
echo "----------Acrhive-----------"

#xcrun xcodebuild -exportArchive -archivePath TravisTest.xcarchive -exportPath Ipas/Dev -exportOptionsPlist "./scripts/certs/DevExportOptions.plist"

xcrun xcodebuild -exportArchive -archivePath TravisTest.xcarchive -exportPath Ipas/Adhoc -exportOptionsPlist "./scripts/certs/AdhocExportOptions.plist"


#mv Ipas/Dev/TravisTest.ipa ./TravisTest-Dev.ipa
mv Ipas/Adhoc/TravisTest.ipa ./TravisTest-Adhoc.ipa