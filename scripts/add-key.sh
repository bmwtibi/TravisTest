#!/bin/sh

# Create a custom keychain
security create-keychain -p $IOS_KEYCHAIN_PWD $IOS_KEYCHAIN_NAME

# Make the custom keychain default, so xcodebuild will use it for signing
security default-keychain -s $IOS_KEYCHAIN_NAME

# Unlock the keychain
security unlock-keychain -p $IOS_KEYCHAIN_PWD $IOS_KEYCHAIN_NAME

# Set keychain timeout to 1 hour for long builds
security set-keychain-settings -t 3600 -l ~/Library/Keychains/$IOS_KEYCHAIN_NAME

# Add certificates to keychain and allow codesign to access them
security import ./scripts/certs/dev_public.cer -k ~/Library/Keychains/$IOS_KEYCHAIN_NAME -A
security import ./scripts/certs/dev_private.p12 -k ~/Library/Keychains/$IOS_KEYCHAIN_NAME -P $IOS_CERT_PASSWORD -A

security import ./scripts/certs/dist_public.cer -k ~/Library/Keychains/$IOS_KEYCHAIN_NAME -A
security import ./scripts/certs/dist_private.p12 -k ~/Library/Keychains/$IOS_KEYCHAIN_NAME -P $IOS_CERT_PASSWORD -A

security import ./scripts/certs/apple.cer -k ~/Library/Keychains/$IOS_KEYCHAIN_NAME -A

security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k travis ~/Library/Keychains/$IOS_KEYCHAIN_NAME