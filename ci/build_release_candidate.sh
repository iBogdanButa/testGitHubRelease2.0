#!/bin/bash

# Description:
### This script can run only on release branch if the previous tag contains -RCN-SNAPSHOT in the name
### This is common code for Release RC and for the HF RC

# Check if the current branch name doesn't match the pattern master
branch_name=$(git rev-parse --abbrev-ref HEAD)
if [[ $branch_name =~ ^master$ ]]; then
  echo "Error: You should build a RC on a relase branch."
  exit 1
fi

# Check if the previous tag follows the format X.Y.Z(-HFN)-RCN-SNAPSHOT
# get the latest tag
git fetch --tags
tag=$(git tag --merged master --sort=-v:refname | grep -E '^[0-9]*+\.[0-9]*+\.[0-9]*+-SNAPSHOT$' | head -n1)

echo "Latest tag is $tag"

