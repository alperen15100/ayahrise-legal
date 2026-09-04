#!/data/data/com.termux/files/usr/bin/bash
set -e
APP="/storage/emulated/0/Download/9353/project-ayah-v1"
cd "$APP"
git checkout play-release
git pull --ff-only origin play-release
python3 - <<'PY'
from pathlib import Path
pairs={
"https://alperen15100.github.io/ayah/privacy.html":"https://alperen15100.github.io/ayahrise-legal/privacy.html",
"https://alperen15100.github.io/ayah/support.html":"https://alperen15100.github.io/ayahrise-legal/support.html",
"https://alperen15100.github.io/ayah/terms.html":"https://alperen15100.github.io/ayahrise-legal/terms.html",
"https://alperen15100.github.io/ayah/sources.html":"https://alperen15100.github.io/ayahrise-legal/sources.html",
}
changed=[]
for p in Path(".").rglob("*"):
    if not p.is_file() or any(x in p.parts for x in (".git","build",".gradle")):
        continue
    try:s=p.read_text(encoding="utf-8")
    except Exception:continue
    ns=s
    for a,b in pairs.items(): ns=ns.replace(a,b)
    if ns!=s:
        p.write_text(ns,encoding="utf-8"); changed.append(str(p))
print("Updated files:")
for x in changed: print("-",x)
PY
git add .
git commit -m "Use public AyahRise legal and support URLs" || true
git push origin play-release
echo "DONE: app legal URLs updated on play-release."
