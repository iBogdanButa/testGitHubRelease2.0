#!/bin/bash

# Description:
### This script can run only on release branch if the previous tag contains -RCN-SNAPSHOT in the name
### This is common code for Release RC and for the HF RC

# Check if the current branch name doesn't match the pattern master
branch_name=$(git rev-parse --abbrev-ref HEAD)
if [[ $branch_name =~ ^master$ ]]; then
  echo "Error: You should build a final release on a relase branch."
  exit 1
fi

# Check if the previous tag follows the format X.Y.Z(-HFN)-RCN-SNAPSHOT
# get the latest tag
git fetch --tags
tag=$(git describe --tags --abbrev=0)

isHF=false
# get the major, minor, patch, RC and HF on else branch 
if [[ $tag =~ ([0-9]+)\.([0-9]+)\.([0-9]+)-RC([0-9]+)-SNAPSHOT ]]; then
    major=${BASH_REMATCH[1]}
    minor=${BASH_REMATCH[2]}
    patch=${BASH_REMATCH[3]}
	rc=${BASH_REMATCH[4]}
elif [[ $tag =~ ([0-9]+)\.([0-9]+)\.([0-9]+)-HF([0-9]+)-RC([0-9]+)-SNAPSHOT ]]; then
	major=${BASH_REMATCH[1]}
    minor=${BASH_REMATCH[2]}
    patch=${BASH_REMATCH[3]}
	hf=${BASH_REMATCH[4]}
	rc=${BASH_REMATCH[5]}
	isHF=true;
else
    echo "Error: tag ($tag) is not in the correct format" >&2
    exit 1
fi