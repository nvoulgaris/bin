#!/bin/bash

inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"

if [ ! "$inside_git_repo" ]; then
  echo "Not a git repo. Exiting..."
  exit 1
fi

current_branch="$(git branch | grep ^* | tr -d "*" | tr -d " ")"
get_local_branches="$(git branch --format='%(refname:short)' | grep -v "master" | grep -v "dev" | grep -v "$current_branch")"

local_branches=$(echo $get_local_branches | tr " " "\n")

for branch in $local_branches; do
  echo "Deleting $branch"
  git branch -d $branch
done
