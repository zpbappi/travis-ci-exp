#!/bin/bash

jekyll build
git remote set-url --push origin $GH_REPO
git config user.name $GIT_NAME
git config user.email $GIT_EMAIL
git config credential.helper "store --file=.git/credentials"
echo "https://${GH_TOKEN}:@github.com" > .git/credentials
git add _site/*
git commit -m "[ci skip] Travis Build - ${TRAVIS_BUILD_NUMBER}"
if [ "$?" = "0" ]; then
	git push origin HEAD:master
else
	echo "Nothing to commit" 1>&2
fi
rm -r .git/credentials
exit 0