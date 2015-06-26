#!/bin/bash

. _scripts/utility.sh

ret=$( is_branch_release $TRAVIS_BRANCH )
if [[ 0 == $ret ]]
then
  _scripts/release-branch.sh
  exit 0
fi

ret=$( is_tag_release $TRAVIS_TAG )
if [[ 0 == $ret ]]
then
  _scripts/npm/tag.sh
  exit 0
fi

echo "[INFO] Cannot deploy the changes. This build was not instructed to deploy by either branch name or tag."
echo "Branch: $TRAVIS_BRANCH"
echo "TAG: $TRAVIS_TAG"
echo "[INFO] Exiting deployment step normally..."
exit 0
