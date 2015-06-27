#!/bin/bash

. _scripts/utility.sh
. _scripts/github.sh

version=$(get_version_from_branch_name $TRAVIS_BRANCH)

echo "[INFO] Creating GitHub release for version $version"

gh_release "$GH_TOKEN" "$version"