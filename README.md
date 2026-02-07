# darling-patches
This is a collection of patches for darling to add support for ARM64

## Usage
Some script have been made for convenience to work with the darling repo:
- `save-patches.sh`: Takes all untracked files and crates a `patches/` folder outside the darling repo with all the changes, taking submodules into account recursively
- `apply-patches.sh`: Receives a patches folder and applies all patches to the project, recursing all submodules 
- `reset-hard.sh`: Does a `git reset --hard` on the repo and all submodules at once

## Patches made

### 01-cmake
Adds support for generating cmake build files, use -DTARGET_ARM64=ON to toggle
