#!/bin/bash

. _scripts/utility.sh
. _scripts/github.sh

version="$1"
echo "[INFO] Creating GitHub release for version $version"

gh_release "$GH_TOKEN" "$version"

upload_url=$( get_assets_url "$GH_TOKEN" "zpbappi/travis-ci-exp" "$version" )
echo "test additional upload version $version" > info.txt
# add_files_to_release $gh_token $url $file_path $file_name $content_type
add_files_to_release "$GH_TOKEN" "$upload_url" "./info.txt" "info.txt" "text/plain"