#!/bin/bash

. _scripts/utility.sh

ret=$( is_releasable $TRAVIS_TAG $TRAVIS_COMMIT )

if [[ 0 != $ret ]]
then
  echo "Cannot deploy the changes. Either the commit message does not start with [release] instruction, or tag is not defined properly using semver (or, both)."
  echo "Commit message: $TRAVIS_COMMIT"
  echo "TAG: $TRAVIS_TAG"
  echo "Exiting deployment step normally..."
  exit 0
fi

saved_dir=$(pwd)
tmp_dir=/tmp/npm-deploy

# delete if it exists. though it shouldn't exist, but it is good to check.
if [[ -d $tmp_dir ]]
then
  rm -rf $tmp_dir
fi

mkdir $tmp_dir
cp _site/* $tmp_dir/
cp _scripts/package.json $tmp_dir/
replaceJsonProp "$tmp_dir/package.json" "version" ".*" "$TRAVIS_TAG"
cd $tmp_dir
npm-publish --npmuser "$NPM_USER" --npmemail "$GIT_EMAIL" --npmpassword "$NPM_PASSWORD"
cd $saved_dir
rm -rf $tmp_dir
