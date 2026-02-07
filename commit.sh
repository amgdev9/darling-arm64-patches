#!/bin/bash

repo_root=$(git rev-parse --show-toplevel)

read -rp "Enter commit message: " commit_msg

# Stage and commit changes in each modified submodule first
git submodule foreach --recursive '
  if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "'"$commit_msg"'"
  fi
'

# Now commit the main repo, which will include updated submodule references
cd "$repo_root"
git add .
if [ -n "$(git status --porcelain)" ]; then
    git commit -m "$commit_msg"
fi

echo "All submodules and main repo committed successfully"

