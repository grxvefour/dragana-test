#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
V="$ROOT/vendor"; D="$ROOT/data"
EXCLUDES=(--exclude='.git' --exclude='.gitignore' --exclude='LICENSE' --exclude='README.md' --exclude='COPYRIGHT_NOTICE')
rm -rf "$D"; mkdir -p "$D/languages" "$D/voices"
rsync -a "${EXCLUDES[@]}" "$V/Serbian/" "$D/languages/Serbian/"
rsync -a "${EXCLUDES[@]}" "$V/dragana/" "$D/voices/dragana/"
find "$D" -type f ! -name '*.gz' -print0 | while IFS= read -r -d '' f; do gzip -9 -c "$f" > "$f.gz"; done
python3 - "$D" <<'PY'
import os,sys,json
root=sys.argv[1]
def rels(base):
    out=[]
    for dp,_,fn in os.walk(os.path.join(root,base)):
        for f in fn:
            if not f.endswith('.gz'):
                out.append(os.path.relpath(os.path.join(dp,f),root).replace(os.sep,'/'))
    return sorted(out)
manifest={'language':rels('languages'),'voices':{'dragana':rels('voices/dragana')}}
with open(os.path.join(root,'manifest.json'),'w') as fh: json.dump(manifest,fh)
print('manifest files:',len(manifest['language'])+len(manifest['voices']['dragana']))
PY
