#!/bin/bash
xcodebuild -project IosPokedexObjC.xcodeproj -scheme IosPokedexObjC CODE_SIGN_IDENTITY=”” CODE_SIGNING_REQUIRED=NO -destination 'platform=iOS Simulator,name=iPhone 14 Pro Max'

