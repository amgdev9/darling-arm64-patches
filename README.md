# darling-patches
This is a collection of patches for darling to add support for ARM64 which are meant to be upstreamed in the future

## Usage
Some scripts have been made for convenience to work with the darling repo, ensure you are using rebase to avoid problems, having your commits on top of upstream is expected:
- `save-patches.sh`: Saves all commits for main repo and all submodules to ../patches (removing the folder first) 
- `apply-patches.sh`: Looks in ../patches folder and applies all patches to the project, recursing all submodules 
- `reset-hard.sh`: Does a `git reset --hard` on the repo and all submodules at once
- `commit.sh`: Gives a commit message once and commits the main repo and all submodules

## Cross compilation
- Create an arm64 linux rootfs (e.g. using debootstrap + qemu or copy from a real arm64 device)
- Create a cmake toolchain file, it's recommended to use `lld` instead of `ld` as this one has cross linking support by default:
```
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)

set(CMAKE_C_FLAGS "--target=aarch64-linux-gnu --sysroot=/path/to/rootfs")
set(CMAKE_CXX_FLAGS "--target=aarch64-linux-gnu --sysroot=/path/to/rootfs")
set(CMAKE_EXE_LINKER_FLAGS "--target=aarch64-linux-gnu --sysroot=/path/to/rootfs -fuse-ld=lld")
set(CMAKE_SHARED_LINKER_FLAGS "--target=aarch64-linux-gnu --sysroot=/path/to/rootfs -fuse-ld=lld")

# Tell CMake where to find pkg-config and the target libraries
set(ENV{PKG_CONFIG_ALLOW_CROSS} 1)
set(ENV{PKG_CONFIG_SYSROOT_DIR} /path/to/rootfs)
set(ENV{PKG_CONFIG_LIBDIR} /path/to/rootfs/usr/lib/aarch64-linux-gnu/pkgconfig:/path/to/rootfs/usr/share/pkgconfig)
```

- Generate cmake project with
`cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain-arm64.cmake -DCOMPONENTS=system -DTARGET_i386=OFF -DTARGET_x86_64=OFF -DTARGET_ARM64=ON -GNinja ..`
