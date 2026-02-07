# darling-patches
This is a collection of patches for darling to add support for ARM64 which are meant to be upstreamed in the future

## Usage
Some scripts have been made for convenience to work with the darling repo, ensure you are using rebase to avoid problems, having your commits on top of upstream is expected:
- `save-patches.sh`: Saves all commits for main repo and all submodules to ../patches (removing the folder first) 
- `apply-patches.sh`: Looks in ../patches folder and applies all patches to the project, recursing all submodules 
- `reset-hard.sh`: Does a `git reset --hard` on the repo and all submodules at once
- `commit.sh`: Gives a commit message once and commits the main repo and all submodules

