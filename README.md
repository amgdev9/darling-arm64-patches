# darling-patches
This is a collection of patches for darling to add support for ARM64 which are meant to be upstreamed in the future

## Usage
Some scripts have been made for convenience to work with the darling repo:
- `save-patches.sh`: Takes all untracked files and creates a `patches/` folder outside the darling repo with all the changes, taking submodules into account recursively
- `apply-patches.sh`: Receives a patches folder and applies all patches to the project, recursing all submodules 
- `reset-hard.sh`: Does a `git reset --hard` on the repo and all submodules at once
- `commit.sh`: Gives a commit message once and commits the main repo and all submodules

## Patches made

### 01-cmake
Adds support for generating cmake build files, use -DTARGET_ARM64=ON to toggle
