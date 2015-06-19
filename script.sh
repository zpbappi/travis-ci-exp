#!/bin/bash

jekyll build
rm -rf _site/script.sh
git remote set-url --push origin $GH_REPO
git config user.name $GIT_NAME
git config user.email $GIT_EMAIL
git config credential.helper "store --file=.git/credentials"
echo "https://${GH_TOKEN}:@github.com" > .git/credentials
git add --all _site/*
git commit -m "[ci skip] Travis Build - ${TRAVIS_BUILD_NUMBER}" > /dev/null 2>&1
if [ "$?" != "0" ]; then
	echo ">>> Nothing changed inside _site/ to commit"
	exit 0
fi
git push --force --quiet origin HEAD:master > /dev/null 2>&1
rm -r .git/credentials
