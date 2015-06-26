#!/bin/bash

. _scripts/utility.sh
. _scripts/git-helper.sh

# bower_publish version src_repo_slug
bower_publish(){
  echo "[INFO] Publishing version $1 to bower repo $2"
  version=$1
  src_repo_slug=$2
  gh_bower_repo_url=$(github_url_from_slug "$src_repo_slug-bower")
  
  cwd=$(pwd)
  
  tmp_dir=/tmp/bower-publish
  
  git_clone $tmp_dir $gh_bower_repo_url
  github_auth "$GIT_NAME" "$GIT_EMAIL" "$GH_TOKEN" $tmp_dir
  
  cp -f _scripts/bower/bower.json $tmp_dir/bower.json
  replaceJsonProp "$tmp_dir/bower.json" "version" ".*" "$version"
  
  cd $tmp_dir
  git add -A
  git_commit_n_push "[automated publishing] version $version" "master"
  
  cd $cwd
  rm -rf $tmp_dir
}