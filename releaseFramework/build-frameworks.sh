#!/bin/bash
set -euo pipefail

VERSION=v3.0.5

cd "$(dirname "$0")/.."
ROOT="$(pwd)"

_build() {
    name=$1
    format=${2:-}

    rm -rf "$ROOT/framework"
    cd "$ROOT/releaseFramework"
    ./release-libKSYLive.sh libksygpulive $name $format

    cd "$ROOT"
    git checkout prebuilt/libs -q

    formatPart=""
    if [[ -n $format ]]; then
        formatPart="_${format}"
    fi
    zip -q --symlinks -s 95m -r libksygpulive.framework_${name}${formatPart}_${VERSION}.zip framework

    rm -rf "$ROOT/framework"
}

rm -rf "$ROOT"/libksygpulive.framework*

_build lite
_build lite dy
_build 265
_build 265 dy
