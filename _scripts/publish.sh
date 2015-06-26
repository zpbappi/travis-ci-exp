#!/bin/bash

. _scripts/utility.sh

publish_targets=(
  "npm"
)

ret=$( is_branch_release $TRAVIS_BRANCH )
if [[ 0 == $ret ]]
then
  for pub in "${publish_targets[@]}"
  do
    echo "[INFO] Intiating publish to $pub by branch: $TRAVIS_BRANCH"
    _scripts/$pub/branch.sh
  done

  exit 0
fi

ret=$( is_tag_release $TRAVIS_TAG )
if [[ 0 == $ret ]]
then
  for pub in "${publish_targets[@]}"
  do
    echo "[INFO] Intiating publish to $pub by TAG: $TRAVIS_TAG"
    _scripts/$pub/tag.sh
  done
  
  exit 0
fi

echo "[INFO] Cannot deploy the changes. This build was not instructed to deploy by either branch name or tag."
echo "Branch: $TRAVIS_BRANCH"
echo "TAG: $TRAVIS_TAG"
echo "[INFO] Exiting deployment step normally..."

exit 0
