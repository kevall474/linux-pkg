#_                   _ _ _  _ _____ _  _
#| | _______   ____ _| | | || |___  | || |
#| |/ / _ \ \ / / _` | | | || |_ / /| || |_
#|   <  __/\ V / (_| | | |__   _/ / |__   _|
#|_|\_\___| \_/ \__,_|_|_|  |_|/_/     |_|

#Maintainer: kevall474 <kevall474@tuta.io> <https://github.com/kevall474>
#Credits: Jan Alexander Steffens (heftig) <heftig@archlinux.org> ---> For the base PKGBUILD
#Credits: Andreas Radke <andyrtr@archlinux.org> ---> For the base PKGBUILD
#Credits: Linus Torvalds ---> For the linux kernel
#Credits: Joan Figueras <ffigue at gmail dot com> ---> For the base PKFBUILD
#Credits: Piotr Gorski <lucjan.lucjanov@gmail.com> <https://github.com/sirlucjan/kernel-patches> ---> For the patches and the base pkgbuild
#Credits: Tk-Glitch <https://github.com/Tk-Glitch> ---> For some patches. base PKGBUILD and prepare script
#Credits: Con Kolivas <kernel@kolivas.org> <http://ck.kolivas.org/> ---> For MuQSS patches
#Credits: Hamad Al Marri <https://github.com/hamadmarri/cachy-sched> ---> For CacULE CPU Scheduler patch
#Credits: Alfred Chen <https://gitlab.com/alfredchen/projectc> ---> For the BMQ/PDS CPU Scheduler patch

################# CPU Scheduler #################

#Set CPU Scheduler
#Set '1' for MuQSS CPU Scheduler
#Set '2' for BMQ CPU Scheduler
#Set '3' for PDS CPU Scheduler
#Set '4' for CacULE CPU Scheduler
#Set '5' for UPDS CPU Scheduler
#Set '6' for CacULE-RDB CPU Scheduler
#Leave empty for no CPU Scheduler
#Default is empty. It will build with no cpu scheduler. To build with cpu shceduler just use : env _cpu_sched=(1,2 or 3) makepkg -s
if [ -z ${_cpu_sched+x} ]; then
  _cpu_sched=
fi

################################# Arch ################################

ARCH=x86

################################# CC/CXX/HOSTCC/HOSTCXX ################################

#Set compiler to build the kernel
#Set '1' to build with GCC
#Set '2' to build with CLANG and LLVM
#Default is empty. It will build with GCC. To build with different compiler just use : env _compiler=(1 or 2) makepkg -s
if [ -z ${_compiler+x} ]; then
  _compiler=
fi

if [[ "$_compiler" = "1" ]]; then
  CC=gcc
  CXX=g++
  HOSTCC=gcc
  HOSTCXX=g++
elif [[ "$_compiler" = "2" ]]; then
  CC=clang
  CXX=clang++
  HOSTCC=clang
  HOSTCXX=clang++
else
  _compiler=1
  CC=gcc
  CXX=g++
  HOSTCC=gcc
  HOSTCXX=g++
fi

###################################################################################

# This section set the pkgbase based on the cpu scheduler, so user can build different package based on the cpu scheduler.
if [[ $_cpu_sched = "1" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=linux-kernel-muqss-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-muqss-clang
  fi
elif [[ $_cpu_sched = "2" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=linux-kernel-bmq-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-bmq-clang
  fi
elif [[ $_cpu_sched = "3" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=linux-kernel-pds-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-pds-clang
  fi
elif [[ $_cpu_sched = "4" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=linux-kernel-cacule-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-cacule-clang
  fi
elif [[ $_cpu_sched = "5" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=linux-kernel-upds-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-upds-clang
  fi
elif [[ $_cpu_sched = "6" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=linux-kernel-cacule-rdb-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-cacule-rdb-clang
  fi
else
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=linux-kernel-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-clang
  fi
fi
pkgname=("$pkgbase" "$pkgbase-headers")
for _p in "${pkgname[@]}"; do
  eval "package_$_p() {
    $(declare -f "_package${_p#$pkgbase}")
    _package${_p#$pkgbase}
  }"
done
pkgver=5.11.16
major=5.11
pkgrel=1
arch=(x86_64)
url="https://www.kernel.org/"
license=(GPL-2.0)
makedepends=("bison" "flex" "valgrind" "git" "cmake" "make" "extra-cmake-modules" "libelf" "elfutils"
             "python" "python-appdirs" "python-mako" "python-evdev" "python-sphinx_rtd_theme" "python-graphviz" "python-sphinx"
             "clang" "lib32-clang" "bc" "gcc" "gcc-libs" "lib32-gcc-libs" "glibc" "lib32-glibc" "pahole" "patch" "gtk3" "llvm" "lib32-llvm"
             "llvm-libs" "lib32-llvm-libs" "lld" "kmod" "libmikmod" "lib32-libmikmod" "xmlto" "xmltoman" "graphviz" "imagemagick" "imagemagick-doc"
             "rsync" "cpio" "inetutils" "gzip" "zstd" "xz")
patchsource=https://raw.githubusercontent.com/kevall474/kernel-patches/main/$major
source=("https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-$pkgver.tar.xz"
        "config-5.11"
        "$patchsource/cpu-patches/0001-cpu-5.11-merge-graysky-s-patchset.patch"
        "$patchsource/cpu-patches/0002-init-Kconfig-enable-O3-for-all-arches.patch"
        "$patchsource/misc/0001-LL-kconfig-add-750Hz-timer-interrupt-kernel-config-o.patch"
        "$patchsource/misc/0005-Disable-CPU_FREQ_GOV_SCHEDUTIL.patch"
        "$patchsource/xanmod-patches/0001-xanmod-patches.patch"
        "$patchsource/zen-patches/0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-C.patch"
        "$patchsource/zen-patches/0001-ZEN-Add-VHBA-driver.patch"
        "$patchsource/zen-patches/0003-ZEN-vhba-Update-to-20210418.patch"
        "$patchsource/zen-patches/0002-ZEN-intel-pstate-Implement-enable-parameter.patch"
        "$patchsource/futex-patches/0001-futex2-resync-from-gitlab.collabora.com.patch"
        "$patchsource/clearlinux-patches/0001-clearlinux-patches.patch"
        "$patchsource/ntfs3-patches/0001-ntfs3-patches.patch"
        "$patchsource/block-patches/0001-block-patches.patch"
        "$patchsource/bfq-patches/0001-bfq-patches.patch"
        "$patchsource/aufs-patches/0001-aufs-20210412.patch"
        "$patchsource/bbr2-patches/0001-bbr2-5.11-introduce-BBRv2.patch"
        "$patchsource/btrfs-patches/0001-btrfs-patches.patch"
        "$patchsource/loopback-patches/0001-v4l2loopback-5.11-merge-v0.12.5.patch"
        "$patchsource/mm-patches/0001-mm-patches.patch"
        "$patchsource/spadfs-patches/0001-spadfs-5.11-merge-v1.0.13.patch"
        "$patchsource/zswap-patches/0001-zswap-patches.patch"
        "$patchsource/pf-patches/0001-pf-patches.patch"
        "$patchsource/arch-patches/0002-HID-quirks-Add-Apple-Magic-Trackpad-2-to-hid_have_sp.patch"
        "$patchsource/android-patches/0001-Export-symbols-needed-by-Android-drivers.patch"
        "$patchsource/android-patches/0002-android-Enable-building-ashmem-and-binder-as-modules.patch"
        "$patchsource/ksm-patches/0001-ksm-patches.patch"
        "$patchsource/zstd-patches/0001-zstd-patches.patch"
        "$patchsource/zstd-patches/0001-zstd-dev-patches.patch"
        "$patchsource/lqx-patches/0001-lqx-patches.patch"
        "$patchsource/wine-patches/0007-v5.11-winesync.patch"
        "$patchsource/misc/vm.max_map_count.patch"
        "$patchsource/initramfs-patches/0001-initramfs-patches.patch")
md5sums=("c7536df1e1e3d03621092d732c8a5b6e"  #linux-5.11.16.tar.xz
         "2af355d97f95713297c707c740e4f432"  #config-5.11
         "fcb1edf2e91ff227c44aeac8b42409aa"  #0001-cpu-5.11-merge-graysky-s-patchset.patch
         "d16247a3ccca283c96577dc138cf9572"  #0002-init-Kconfig-enable-O3-for-all-arches.patch
         "d15597054a4c5e405f980d07d5eac11a"  #0001-LL-kconfig-add-750Hz-timer-interrupt-kernel-config-o.patch
         "f99b82d6f424d1a729a9b8c5a1be2b84"  #0005-Disable-CPU_FREQ_GOV_SCHEDUTIL.patch
         "c87afb8937411d41e7460c4c80a67464"  #0001-xanmod-patches.patch
         "6dfd8a5a0bcf8fe205213e36d70770a6"  #0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-C.patch
         "29aa42972ef0aaf3d879ba33a22a7d2e"  #0001-ZEN-Add-VHBA-driver.patch
         "5618bf0ec5602a794e6a2b67f81b3ec8"  #0003-ZEN-vhba-Update-to-20210418.patch
         "7fb92823fa7d9f7a79d650444561c18d"  #0002-ZEN-intel-pstate-Implement-enable-parameter.patch
         "307f39a7c060ac3073607964091234c0"  #0001-futex2-resync-from-gitlab.collabora.com.patch
         "57f4afa1be10eec300542767942ad938"  #0001-clearlinux-patches.patch
         "aecc37df9f4a28953c6759b82207aaf7"  #0001-ntfs3-patches.patch
         "3cf79ddcad9c0f659664bd6fc2ae30ec"  #0001-block-patches.patch
         "f506e2aad80616f7334fabcb1cbaed0d"  #0001-bfq-patches.patch
         "5c8d12d4577e46ba118e4f18469c7f49"  #0001-aufs-20210412.patch
         "686d82306fff905945ffb6f0eede14d4"  #0001-bbr2-5.11-introduce-BBRv2.patch
         "2d9f85cdf7d8c526b5eaa4341ac4058c"  #0001-btrfs-patches.patch
         "0ab93e8e3437a5093520c10cca741531"  #0001-v4l2loopback-5.11-merge-v0.12.5.patch
         "7547ce8af415e4d587258fdf928a7eee"  #0001-mm-patches.patch
         "49b4c1a2098d0f0584eb8d0eda2a60c9"  #0001-spadfs-5.11-merge-v1.0.13.patch
         "64e629e48f15cc0ebddfee366386f17a"  #0001-zswap-patches.patch
         "f7e7e6cddb72ad8ae741849dddb6e6fa"  #0001-pf-patches.patch
         "e7ef63d6e6fb1ed9d8c2b4d3f65de86c"  #0002-HID-quirks-Add-Apple-Magic-Trackpad-2-to-hid_have_sp.patch
         "3b5866097de15af399841405bc844020"  #0001-Export-symbols-needed-by-Android-drivers.patch
         "0eda7e947dd25e6b77ea40d734deea8d"  #0002-android-Enable-building-ashmem-and-binder-as-modules.patch
         "9c37d7643710ffa49552cc43b96980ed"  #0001-ksm-patches.patch
         "eccf701cb0f604c5fb9f06b500585889"  #0001-zstd-patches.patch
         "d8f8f4d1c025952b3022126273b62c93"  #0001-zstd-dev-patches.patch
         "95b7d848ff2dc7bf7779a6177420c02a"  #0001-lqx-patches.patch
         "ab8f21e210aec26c7825033d57433e33"  #0007-v5.11-winesync.patch
         "27e6001bacfcfca1c161bf6ef946a79b"  #vm.max_map_count.patch
         "39d8fe1921a28bb6504f4eb23aa5d675") #0001-initramfs-patches.patch)
#zenify workarround with CacULE
if [[ $_cpu_sched != "4" ]] && [[ $_cpu_sched != "6" ]]; then
 source+=("$patchsource/misc/zenify.patch")
 md5sums+=("8e71f0c43157654c4105224d89cc6709")  #zenify.patch
fi
if [[ $_cpu_sched = "1" ]]; then
 source+=("$patchsource/muqss-patches/patch-5.11-ck1")
 md5sums+=("SKIP")
elif [[ $_cpu_sched = "2" ]] || [[ $_cpu_sched = "3" ]]; then
  source+=("${patchsource}/prjc-patches/0009-prjc_v5.11-r3.patch")
  md5sums+=("3ed563f52e61ceabcb8dea99256635c2")  #0009-prjc_v5.11-r3.patch
elif [[ $_cpu_sched = "4" ]] || [[ $_cpu_sched = "6" ]]; then
  source+=("${patchsource}/cacule-patches/cacule-5.11.patch"
           "${patchsource}/cacule-patches/0002-cacule-Change-default-preemption-latency-to-2ms-for-.patch"
           "${patchsource}/cacule-patches/0003-cacule-Set-cacule_harsh_mode-enabled-by-default.patch")
  md5sums+=("b85d9c75a137a4278537386ca274da9d"  #cacule-5.11.patch
            "cdf2d612b6c1234ce124f0e8361fdc2e"  #0002-cacule-Change-default-preemption-latency-to-2ms-for-.patch
            "09ca141fe7aff2a0f426e1d79f45aba3") #0003-cacule-Set-cacule_harsh_mode-enabled-by-default.patch
elif [[ $_cpu_sched = "5" ]]; then
  source+=("${patchsource}/upds-patches/0005-v5.11_undead-pds099o.patch")
  md5sums+=("1c6d05cffa90464a2ae6f9e00d670e50")  #0005-v5.11_undead-pds099o.patch
fi

export KBUILD_BUILD_HOST=archlinux
export KBUILD_BUILD_USER=$pkgbase
export KBUILD_BUILD_TIMESTAMP="$(date -Ru${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH})"

prepare(){

  cd linux-$pkgver

  # Apply any patch
  local src
  for src in "${source[@]}"; do
    src="${src%%::*}"
    src="${src##*/}"
    [[ $src = *.patch ]] || continue
    msg2 "Applying patch $src..."
    patch -Np1 < "../$src"
  done

  if [[ $_cpu_sched = "1" ]]; then
    msg2 "Applying patch patch-5.11-ck1"
    patch -Np1 < ../patch-5.11-ck1
 fi

  # Copy the config file first
  # Copy "${srcdir}"/config to linux-${pkgver}/.config
  msg2 "Copy "${srcdir}"/config to linux-$pkgver/.config"
  cp "${srcdir}"/config-$major .config

  # Customize the kernel
  source "${startdir}"/prepare
  source "${startdir}"/rapid_config
  source "${startdir}"/strip_down

  configure

  cpu_arch

  # Automation building with rapid_config
  # Uncomment rapid_config and comment out configure and cpu_arch
  # rapid_config is meant to work with build.sh for automation building
  #rapid_config

  # strip_down script
  #strip_down

  # Setting localversion
  msg2 "Setting localversion..."
  scripts/setlocalversion --save-scmversion
  echo "-${pkgbase}" > localversion

  # Config
  if [[ "$_compiler" = "1" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} olddefconfig
  elif [[ "$_compiler" = "2" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} olddefconfig
  fi

  make -s kernelrelease > version
  msg2 "Prepared $pkgbase version $(<version)"
}

build(){

  cd linux-$pkgver

  # make -j$(nproc) all
  msg2 "make -j$(nproc) all..."
  if [[ "$_compiler" = "1" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} -j$(nproc) all
  elif [[ "$_compiler" = "2" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} -j$(nproc) all
  fi
}

_package(){
  pkgdesc="Stable linux kernel and modules with a set of patches by TK-Glitch and Piotr Górski"
  depends=("coreutils" "kmod" "initramfs" "mkinitcpio")
  optdepends=("linux-firmware: firmware images needed for some devices"
              "crda: to set the correct wireless channels of your country")
  provides=("VIRTUALBOX-GUEST-MODULES" "WIREGUARD-MODULE")

  cd linux-$pkgver

  local kernver="$(<version)"
  local modulesdir="${pkgdir}"/usr/lib/modules/${kernver}

  msg2 "Installing boot image..."
  # systemd expects to find the kernel here to allow hibernation
  # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab8128dcf99161d2344
  install -Dm644 arch/${ARCH}/boot/bzImage "$modulesdir/vmlinuz"

  # Used by mkinitcpio to name the kernel
  echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase"

  msg2 "Installing modules..."
  if [[ "$_compiler" = "1" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} INSTALL_MOD_PATH="${pkgdir}"/usr INSTALL_MOD_STRIP=1 -j$(nproc) modules_install
  elif [[ "$_compiler" = "2" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} INSTALL_MOD_PATH="${pkgdir}"/usr INSTALL_MOD_STRIP=1 -j$(nproc) modules_install
  fi

  # remove build and source links
  msg2 "Remove build dir and source dir..."
  rm -rf "$modulesdir"/{source,build}
}

_package-headers(){
  pkgdesc="Headers and scripts for building modules for the $pkgbase package"
  depends=("${pkgbase}" "pahole")

  cd linux-$pkgver

  local builddir="$pkgdir"/usr/lib/modules/"$(<version)"/build

  msg2 "Installing build files..."
  install -Dt "$builddir" -m644 .config Makefile Module.symvers System.map localversion version vmlinux
  install -Dt "$builddir/kernel" -m644 kernel/Makefile
  install -Dt "$builddir/arch/x86" -m644 arch/x86/Makefile
  cp -t "$builddir" -a scripts

  # add objtool for external module building and enabled VALIDATION_STACK option
  install -Dt "$builddir/tools/objtool" tools/objtool/objtool

  # add xfs and shmem for aufs building
  mkdir -p "$builddir"/{fs/xfs,mm}

  msg2 "Installing headers..."
  cp -t "$builddir" -a include
  cp -t "$builddir/arch/x86" -a arch/x86/include
  install -Dt "$builddir/arch/x86/kernel" -m644 arch/x86/kernel/asm-offsets.s

  install -Dt "$builddir/drivers/md" -m644 drivers/md/*.h
  install -Dt "$builddir/net/mac80211" -m644 net/mac80211/*.h

  # http://bugs.archlinux.org/task/13146
  install -Dt "$builddir/drivers/media/i2c" -m644 drivers/media/i2c/msp3400-driver.h

  # http://bugs.archlinux.org/task/20402
  install -Dt "$builddir/drivers/media/usb/dvb-usb" -m644 drivers/media/usb/dvb-usb/*.h
  install -Dt "$builddir/drivers/media/dvb-frontends" -m644 drivers/media/dvb-frontends/*.h
  install -Dt "$builddir/drivers/media/tuners" -m644 drivers/media/tuners/*.h

  msg2 "Installing KConfig files..."
  find . -name 'Kconfig*' -exec install -Dm644 {} "$builddir/{}" \;

  msg2 "Removing unneeded architectures..."
  local arch
  for arch in "$builddir"/arch/*/; do
    [[ $arch = */x86/ ]] && continue
    msg2 "Removing $(basename "$arch")"
    rm -r "$arch"
  done

  msg2 "Removing documentation..."
  rm -r "$builddir/Documentation"

  msg2 "Removing broken symlinks..."
  find -L "$builddir" -type l -printf 'Removing %P\n' -delete

  msg2 "Removing loose objects..."
  find "$builddir" -type f -name '*.o' -printf 'Removing %P\n' -delete

  msg2 "Stripping build tools..."
  local file
  while read -rd '' file; do
    case "$(file -bi "$file")" in
      application/x-sharedlib\;*)      # Libraries (.so)
        strip -v $STRIP_SHARED "$file" ;;
      application/x-archive\;*)        # Libraries (.a)
        strip -v $STRIP_STATIC "$file" ;;
      application/x-executable\;*)     # Binaries
        strip -v $STRIP_BINARIES "$file" ;;
      application/x-pie-executable\;*) # Relocatable binaries
        strip -v $STRIP_SHARED "$file" ;;
    esac
  done < <(find "$builddir" -type f -perm -u+x ! -name vmlinux -print0)

  msg2 "Stripping vmlinux..."
  strip -v $STRIP_STATIC "$builddir/vmlinux"

  msg2 "Adding symlink..."
  mkdir -p "$pkgdir/usr/src"
  ln -sr "$builddir" "$pkgdir/usr/src/$pkgbase"
}
