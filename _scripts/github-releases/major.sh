#!/bin/bash

. _scripts/utility.sh
. _scripts/github.sh

echo "[INFO] Creating GitHub release for version $VERSION"

gh_release "$GH_TOKEN" "$VERSION"