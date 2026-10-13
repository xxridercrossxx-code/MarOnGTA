#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
python3 Scripts/prepare_heap_diagnostics.py
python3 Scripts/prepare_memory_pressure.py
python3 Scripts/prepare_virtual_pad.py
python3 Scripts/prepare_movie_wait.py
python3 Scripts/prepare_missing_txd.py
python3 Scripts/prepare_unchecked_memory.py
python3 Scripts/build_metal_shaders.py "${PG_SHADER_DIR:-Build/Inputs/shaders}" --sdk iphonesimulator
xcodegen generate --spec project.yml
xcodebuild -project PlayGTA5Native.xcodeproj -scheme PlayGTA5Native \
  -configuration Release -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' -derivedDataPath Build/Simulator \
  -jobs 2 ARCHS=arm64 ONLY_ACTIVE_ARCH=YES GCC_OPTIMIZATION_LEVEL=2 \
  SWIFT_OPTIMIZATION_LEVEL=-O CODE_SIGNING_ALLOWED=NO DEBUG_INFORMATION_FORMAT=dwarf build
