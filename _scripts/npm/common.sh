#!/bin/bash

. _scripts/utility.sh

publish_npm(){
  saved_dir=$(pwd)
  tmp_dir=/tmp/npm-release

  # delete if it exists. though it shouldn't exist, but it is good to check.
  if [[ -d $tmp_dir ]]
  then
    rm -rf $tmp_dir
  fi
  
  mkdir $tmp_dir
  cp _site/* $tmp_dir/
  cp _scripts/npm/package.json $tmp_dir/
  replaceJsonProp "$tmp_dir/package.json" "version" ".*" "$1"
  cd $tmp_dir
  npm-publish --npmuser "$NPM_USER" --npmemail "$GIT_EMAIL" --npmpassword "$NPM_PASSWORD"
  cd $saved_dir
  rm -rf $tmp_dir
  
  return 0
}