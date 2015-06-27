#!/bin/bash

. _scripts/utility.sh
. _scripts/github.sh

publish_targets=(
  "npm"
  "bower"
  "github-releases"
)

$VERSION="$TRAVIS_TAG"

ret=$( is_proper_version $VERSION )
if [[ 0 == $ret ]]
then # it is a proper semver TAG
  pub_script="minor"
  prerelease=$( is_prerelease_version "$VERSION" )
  major=$( is_major_version "$VERSION" )
  if [[ $prerelease == 0 ]]
  then # it is pre-release versioning
    pub_script="pre-release"
  elif [[ $major == 0 ]]
  then # it is major version => [1-9].0.0
    pub_script="major"
  else
    release_gh_branch=$( gh_branch_exists "$GH_TOKEN" "$TRAVIS_REPO_SLUG" "release-$VERSION" )
    if [[ $release_gh_branch == 0 ]]
    then # if it is minor version but there is a branch named release-$version, i consider it major release
      pub_script="major"
    fi
  fi
  
  echo "[INFO] Publishing $pub_script with version $VERSION..."
  for pub in "${publish_targets[@]}"
  do
    
    _scripts/$pub/$pub_script.sh
  done
  
  echo "[INFO] Completed publishing $pub_script with version $VERSION"
  exit 0
fi

echo "[INFO] No publishing step needed as it wasn't tagged with semver to publish. I configured to publish on tags only."
echo "TAG: $TRAVIS_TAG"
echo "[INFO] Nevermind. Exiting deployment step normally. Don't worry about it."

exit 0
