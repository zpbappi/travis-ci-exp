#!/bin/bash

is_releasable(){
	if [[ $TRAVIS_COMMIT == [release]* && $TRAVIS_TAG == ^[1-9][0-9]*\.[0-9]+\.[0-9]+(\-(alpha|beta|rc)(\.[1-9][0-9]*)?)?$ ]] then
		return 0
	fi
	return 1		 
}

# copied from https://github.com/angular/angular.js/blob/master/scripts/utils.inc
# replaceInFile file findPattern replacePattern
replaceInFile() {
  sed -i .tmp -E "s/$2/$3/" $1
  rm $1.tmp
}

# copied from https://github.com/angular/angular.js/blob/master/scripts/utils.inc
# replaceJsonProp jsonFile propertyRegex valueRegex replacePattern
# - note: propertyRegex will be automatically placed into a
#   capturing group! -> all other groups start at index 2!
replaceJsonProp {
  replaceInFile $1 '"('$2')"[ ]*:[ ]*"'$3'"' '"\1": "'$4'"'
}
