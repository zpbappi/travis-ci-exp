#!/bin/bash

. _scripts/npm/common.sh

version=$(get_version_from_branch_name $TRAVIS_BRANCH)
publish_npm $version