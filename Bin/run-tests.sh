#!/bin/bash
if [ ! -d DFDiff.xcworkspace ]; then
  cd ..
fi
xctool test -workspace DFDiff.xcworkspace -scheme DFDiffTests -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO
