#!/usr/bin/env bash
# Build the Flutter web bundle and deploy to Firebase Hosting (rupeshflutter.web.app).
set -euo pipefail
cd "$(dirname "$0")"
flutter build web --release --wasm 2>/dev/null || flutter build web --release
firebase deploy --only hosting,firestore:rules
