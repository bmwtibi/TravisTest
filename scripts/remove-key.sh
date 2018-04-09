#!/bin/sh

security delete-keychain $IOS_KEYCHAIN_NAME
security default-keychain -s login.keychain

