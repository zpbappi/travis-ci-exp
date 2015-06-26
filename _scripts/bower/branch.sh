#!/bin/bash

. _scripts/bower/common.sh

version=$(get_version_from_branch_name $TRAVIS_BRANCH)
bower_publish $version $TRAVIS_REPO_SLUG