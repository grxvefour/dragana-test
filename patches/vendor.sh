#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
V="$ROOT/vendor"
mkdir -p "$V"
clone() {
  if [ -d "$V/$2/.git" ]; then echo "vendor/$2 present"; else git clone --depth 1 "$1" "$V/$2"; fi
}
clone https://github.com/RHVoice/RHVoice RHVoice
clone https://github.com/RHVoice/Serbian-bin Serbian
clone https://github.com/RHVoice/dragana-srp dragana
# RHVoice build dependencies used by the WASM POC
git -C "$V/RHVoice" submodule update --init --depth 1 external/libs/boost external/libs/sonic || \
git -C "$V/RHVoice" submodule update --init --depth 1 external/libs/sonic
