#!/usr/bin/env bash
# Build with the repo base path and force-push build output to the gh-pages branch.
set -euo pipefail
cd "$(dirname "$0")"
flutter build web --release --base-href /rupesh_portfolio/ -o build/pages
touch build/pages/.nojekyll
tmp=$(mktemp -d)
cp -R build/pages/. "$tmp"
cd "$tmp" && git init -q -b gh-pages && git add -A && git commit -q -m "Deploy portfolio to GitHub Pages" \
  && git push -f https://github.com/rupeshrajak0285/rupesh_portfolio.git gh-pages
rm -rf "$tmp"
