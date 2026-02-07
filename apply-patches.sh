#!/bin/bash

patches_folder="$1"

if [ -z "$patches_folder" ]; then
  echo "Usage: $0 <patches_folder>"
  exit 1
fi

patches_folder=$(realpath "$patches_folder")
repo_root=$(git rev-parse --show-toplevel)

# Apply main repo patch
main_patch="$patches_folder/patch"
if [ -f "$main_patch" ]; then
  git apply "$main_patch"
fi

# Apply submodule patches
find "$patches_folder" -type f -name patch ! -path "$main_patch" | while read -r patch_file; do
  # Compute relative submodule path
  rel_path="${patch_file#$patches_folder/}"
  rel_path="$(dirname "$rel_path")"

  # Enter submodule and apply patch using absolute path
  submodule_dir="$repo_root/$rel_path"
  if [ -d "$submodule_dir" ]; then
    (cd "$submodule_dir" && git apply "$patch_file")
  fi
done

echo "Patches applied successfully"

