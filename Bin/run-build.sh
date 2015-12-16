#!/bin/bash
if [ ! -d DFDiff.xcworkspace ]; then
  cd ..
fi
xctool build -workspace DFDiff.xcworkspace -scheme DFDiff -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO
