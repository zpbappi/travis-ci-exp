#!/bin/bash

is_tag_release(){
  tag="$1"

  if [[ "$tag" =~ ^[1-9][0-9]*\.[0-9]+\.[0-9]+(\-(alpha|beta|rc)(\.[1-9][0-9]*)?)?$ ]]
  then
    echo 0
    return 0
  fi

  echo 1
  return 1
}

is_branch_release(){
  branch="$1"
  
  if [[ "$branch" =~ ^[Rr]elease-[1-9][0-9]*\.[0-9]+\.[0-9]+$ ]]
  then
    echo 0
    return 0
  fi
  
  echo 1
  return 1
}

get_version_from_branch_name(){
  version=`echo $1| cut -d'-' -f 2,3,4`
  echo $version
}

# copied from https://github.com/angular/angular.js/blob/master/scripts/utils.inc
# replaceInFile file findPattern replacePattern
replaceInFile() {
  sed -i.tmp -E "s/$2/$3/" $1
  rm $1.tmp
}

# copied from https://github.com/angular/angular.js/blob/master/scripts/utils.inc
# replaceJsonProp jsonFile propertyRegex valueRegex replacePattern
# - note: propertyRegex will be automatically placed into a
#   capturing group! -> all other groups start at index 2!
replaceJsonProp() {
  replaceInFile $1 '"('$2')"[ ]*:[ ]*"'$3'"' '"\1": "'$4'"'
}

