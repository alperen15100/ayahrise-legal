#!/data/data/com.termux/files/usr/bin/bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"
git config --global --add safe.directory "$DIR" >/dev/null 2>&1 || true
rm -rf .git
git init
git config user.name "alperen15100"
git config user.email "ecrincrypto@gmail.com"
git add .
git commit -m "Publish AyahRise legal and support site"
git branch -M main
git remote add origin https://github.com/alperen15100/ayahrise-legal.git
git push -u origin main
echo
echo "DONE: Enable GitHub Pages: Settings > Pages > Deploy from a branch > main > /(root)"
