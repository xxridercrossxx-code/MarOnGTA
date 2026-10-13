#!/bin/bash
# Build an unsigned IPA from YOUR OWN game files.
# Usage: ./build_ipa.sh https://my-pc.tailnet-name.ts.net [--paid]   (files from your server)
#        ./build_ipa.sh --mirror /path/to/game-folder [--paid]     (files already on this machine:
#                                                                    the folder with data/manifest.json and b/)
#   --paid  request the extra-memory entitlements (paid Apple developer account)
# Needs: an Apple Silicon Mac (or the GitHub Actions workflow), Xcode, xcodegen.
set -euo pipefail
SERVER=""
MIRROR=""
if [ "${1:-}" = "--mirror" ]; then MIRROR="$(cd "${2:?Usage: ./build_ipa.sh --mirror /path/to/game-folder [--paid]}" && pwd)"; shift 2
else SERVER="${1:?Usage: ./build_ipa.sh https://your-server [--paid]  or  ./build_ipa.sh --mirror /path [--paid]}"; shift; fi
ENTITLEMENTS=App/Free.entitlements
[ "${1:-}" = "--paid" ] && ENTITLEMENTS=App/Full.entitlements
cd "$(dirname "$0")/app"
JOBS="${JOBS:-$(sysctl -n hw.ncpu)}"
# The system Python runs natively on Apple Silicon (a Rosetta Python would
# make the engine tools build for the wrong CPU).
PY="${PYTHON:-/usr/bin/python3}"

if [ -n "$SERVER" ]; then
  "$PY" Scripts/fetch_game_files.py --server "$SERVER" --out Build/Inputs/mirror
  MIRROR="$PWD/Build/Inputs/mirror"
fi
"$PY" Scripts/check_game_files.py --mirror "$MIRROR"
"$PY" Scripts/prepare.py --mirror "$MIRROR"
# The app opens with your server already filled in (without one, it asks where your files are).
/usr/libexec/PlistBuddy -c "Set :PGDefaultAssetServer $SERVER" App/Info.plist

xcodebuild -project PlayGTA5Native.xcodeproj -scheme PlayGTA5Native \
  -configuration Release -sdk iphoneos -destination 'generic/platform=iOS' \
  -derivedDataPath Build/Release -jobs "$JOBS" \
  GCC_OPTIMIZATION_LEVEL=2 SWIFT_OPTIMIZATION_LEVEL=-O DEBUG_INFORMATION_FORMAT=dwarf \
  CODE_SIGNING_ALLOWED=NO CODE_SIGN_ENTITLEMENTS="$ENTITLEMENTS" build > Build/xcodebuild.log 2>&1 || {
  grep -E 'error:' Build/xcodebuild.log | head -20
  echo "Build failed; the full log is app/Build/xcodebuild.log"; exit 1; }
grep -E 'BUILD SUCCEEDED' Build/xcodebuild.log

APP=Build/Release/Build/Products/Release-iphoneos/PlayGTA5Native.app
# AltStore/SideStore re-sign the app; an ad-hoc signature with the chosen
# entitlements tells them what to request.
codesign --force --sign - --entitlements "$ENTITLEMENTS" --generate-entitlement-der "$APP"
STAGE=Build/IPA
mkdir -p "$STAGE/Payload"
ditto "$APP" "$STAGE/Payload/PlayGTA5Native.app"
(cd "$STAGE" && zip -qry ../../../GTA5Port.ipa Payload)
echo "Done: $(cd .. && pwd)/GTA5Port.ipa"
