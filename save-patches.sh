#!/bin/bash
set -e

repo_root=$(git rev-parse --show-toplevel)
patches_folder="$repo_root/../patches"
echo "Saving patches to $patches_folder"

rm -rf "$patches_folder"
mkdir -p "$patches_folder"

base=$(git merge-base HEAD origin/HEAD)
git format-patch "$base"..HEAD -o "$patches_folder"

git submodule foreach --quiet --recursive '
  base=$(git merge-base HEAD origin/HEAD)
  count=$(git rev-list --count "$base"..HEAD)
  [ "$count" -eq 0 ] && exit 0

  patch_dir="$toplevel/../patches/$path"
  mkdir -p "$patch_dir"

  git format-patch "$base"..HEAD -o "$patch_dir"
'

echo "Done"

