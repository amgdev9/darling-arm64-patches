#!/bin/bash

repo_root=$(git rev-parse --show-toplevel)
patches_folder="$repo_root/../patches"
echo "Saving patches to $patches_folder"

rm -rf "$patches_folder"
mkdir -p "$patches_folder"

git add -N .
git diff --ignore-submodules=all > "$patches_folder/patch"

git submodule foreach --quiet --recursive '
  if [ -n "$(git status --porcelain)" ]; then
    patch_dir="$toplevel/../patches/$path"
    mkdir -p "$patch_dir"
    git add -N .
    git diff --ignore-submodules=all > "$patch_dir/patch"
  fi
'

echo "Done"
