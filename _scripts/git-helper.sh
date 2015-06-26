#!/bin/bash

# git_url_from_slug $slug
github_url_from_slug(){
  echo "https://github.com/$1.git"
}

# git_clone dir url
git_clone(){
	if [[ -d $1 ]]
	then
	  rm -rf $1
	fi
	
	git clone $2 $1
}

# github_auth $name $email $gh_token $repo_dir
github_auth(){
  cwd=$(pwd)
  cd $4
  git config user.name "$1"
  git config user.email "$2"
  git config credential.helper "store --file=.git/credentials"
  echo "https://${3}:@github.com" > .git/credentials
  cd $cwd
}

# git_commit_n_push $message $branch
git_commit_n_push(){
  branch="master"
  if [[ -n "$2" ]]
  then
    branch="$2"
  fi
  
  git commit -q -m "$1" > /dev/null 2>&1
  if [ "$?" == "0" ]; then
    git push --force --quiet origin HEAD:$branch > /dev/null 2>&1
  fi
}