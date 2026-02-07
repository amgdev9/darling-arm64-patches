#!/bin/bash
set -e

repo_root=$(git rev-parse --show-toplevel)
patches_folder="$repo_root/../patches"

[ -d "$patches_folder" ] || exit 0

git submodule foreach --quiet --recursive '
  patch_dir="$toplevel/../patches/$path"
  [ -d "$patch_dir" ] || exit 0

  git am "$patch_dir"/*.patch 2>/dev/null || true
'

git am "$patches_folder"/*.patch 2>/dev/null || true

echo "Done"

