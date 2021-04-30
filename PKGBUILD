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
#Set '1' for CacULE CPU Scheduler
#Set '2' for CacULE-RDB CPU Scheduler
#Set '3' for BMQ CPU Scheduler
#Set '4' for PDS CPU Scheduler
#Set '5' for PDS CPU Scheduler
#Leave empty for no CPU Scheduler
#Default is empty. It will build with no cpu scheduler. To build with cpu shceduler just use : env _cpu_sched=(1,2,3,4 or 5) makepkg -s
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
    pkgbase=linux-kernel-cacule-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-cacule-clang
  fi
elif [[ $_cpu_sched = "2" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=linux-kernel-cacule-rdb-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-cacule-rdb-clang
  fi
elif [[ $_cpu_sched = "3" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=linux-kernel-bmq-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-bmq-clang
  fi
elif [[ $_cpu_sched = "4" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=linux-kernel-pds-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-pds-clang
  fi
elif [[ $_cpu_sched = "5" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=linux-kernel-muqss-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=linux-kernel-muqss-clang
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
pkgver=5.12
major=5.12
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
        "config-$major"
        "$patchsource/bbr2-patches/0001-bbr2-5.12-introduce-BBRv2.patch"
        "$patchsource/block-patches/0001-block-patches.patch"
        "$patchsource/bfq-patches/0001-bfq-patches.patch"
        "$patchsource/btrfs-patches/0001-btrfs-patches.patch"
        "$patchsource/cpu-patches/0001-cpu-5.12-merge-graysky-s-patchset.patch"
        "$patchsource/cpu-patches/0002-init-Kconfig-enable-O3-for-all-arches.patch"
        "$patchsource/clearlinux-patches/0001-clearlinux-patches.patch"
        "$patchsource/futex-patches/0001-futex-resync-from-gitlab.collabora.com.patch"
        "$patchsource/futex2-patches/0001-futex2-resync-from-gitlab.collabora.com.patch"
        "$patchsource/initramfs-patches/0001-initramfs-patches.patch"
        "$patchsource/ksm-patches/0001-ksm-patches.patch"
        "$patchsource/loopback-patches/0001-v4l2loopback-patches.patch"
        "$patchsource/lqx-patches/0001-Revert-net-tso-add-UDP-segmentation-support.patch"
        "$patchsource/lqx-patches/0002-zen-Allow-MSR-writes-by-default.patch"
        "$patchsource/mm-patches/0001-mm-5.12-protect-file-mappings-under-memory-pressure.patch"
        "$patchsource/ntfs3-patches/0001-ntfs3-patches.patch"
        "$patchsource/pf-patches/0001-genirq-i2c-Provide-and-use-generic_dispatch_irq.patch"
        "$patchsource/xanmod-patches/0007-XANMOD-sched-autogroup-Add-kernel-parameter-and-conf.patch"
        "$patchsource/zen-patches/0001-ZEN-Add-VHBA-driver.patch"
        "$patchsource/zen-patches/0003-ZEN-vhba-Update-to-20210418.patch"
        "$patchsource/zen-patches/0002-ZEN-intel-pstate-Implement-enable-parameter.patch"
        "$patchsource/zen-patches/0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-C.patch"
        "$patchsource/zstd-patches/0001-zstd-patches.patch"
        "$patchsource/zstd-dev-patches/0001-zstd-dev-patches.patch"
        "$patchsource/misc-patches/0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch"
        "$patchsource/misc-patches/0002-mm-Support-soft-dirty-flag-read-with-reset.patch"
        "$patchsource/misc-patches/0001-LL-kconfig-add-750Hz-timer-interrupt-kernel-config-o.patch"
        "$patchsource/misc-patches/0003-sched-core-nr_migrate-256-increases-number-of-tasks-.patch"
        "$patchsource/misc-patches/0004-mm-set-8-megabytes-for-address_space-level-file-read.patch"
        "$patchsource/misc-patches/0005-Disable-CPU_FREQ_GOV_SCHEDUTIL.patch"
        "$patchsource/misc-patches/0006-add-acs-overrides_iommu.patch"
        "$patchsource/misc-patches/vm.max_map_count.patch")
md5sums=("8c7420990de85f6754db287337da08b4"  #linux-5.12.tar.xz
         "eb478b647cb6d91a1d96f7cbc194bcda"  #config-5.12
         "f0432ad99030e984d743b504994eb548"  #0001-bbr2-5.12-introduce-BBRv2.patch
         "bb66298bf44eec02c61cb41afa0b39c6"  #0001-block-patches.patch
         "85a23b6f0083fa40d8c014d431bf5f87"  #0001-bfq-patches.patch
         "e0d2a6df4d4a0f64834606f1bdd3e54f"  #0001-btrfs-patches.patch
         "5f77052b651f5e1bc4a98cb92eb39f31"  #0001-cpu-5.12-merge-graysky-s-patchset.patch
         "f785cffc211a32eaebca3696da76fbee"  #0002-init-Kconfig-enable-O3-for-all-arches.patch
         "a61fa575fd689c39fe2f453331e18553"  #0001-clearlinux-patches.patch
         "6f39e6d4f2f0253f317185b0c23e1f40"  #0001-futex-resync-from-gitlab.collabora.com.patch
         "796a2a5f8c171bae377e87584450dbe3"  #0001-futex2-resync-from-gitlab.collabora.com.patch
         "f671bb073df5312915ca3672ea9ecbff"  #0001-initramfs-patches.patch
         "4a0118d6e5dfd3abbf35dd24229e8438"  #0001-ksm-patches.patch
         "1536be060202287506c72d97b73baceb"  #0001-v4l2loopback-patches.patch
         "d484e60f56a308bb456dedbbe139e086"  #0001-Revert-net-tso-add-UDP-segmentation-support.patch
         "93a3ee2b38e20416cb67861eb37344e5"  #0002-zen-Allow-MSR-writes-by-default.patch
         "f28b55fff5b5c83a005ca1677a8da74c"  #0001-mm-5.12-protect-file-mappings-under-memory-pressure.patch
         "73038b6a7e3f0813b78374a8935a0c1a"  #0001-ntfs3-patches.patch
         "2c048d095acfa50e6db0074088ef64c7"  #0001-genirq-i2c-Provide-and-use-generic_dispatch_irq.patch
         "ef1c78ab0e9b983868ffa2dac838ec46"  #0007-XANMOD-sched-autogroup-Add-kernel-parameter-and-conf.patch
         "2abbaa53bb0f5986d2a4acbec9d0cf61"  #0001-ZEN-Add-VHBA-driver.patch
         "bc5130f3f385737bbdf7e7a0cd8d361d"  #0003-ZEN-vhba-Update-to-20210418.patch
         "8bd27bbf98714966f28c792be9b8590d"  #0002-ZEN-intel-pstate-Implement-enable-parameter.patch
         "769a47f843589c2bbca050027f06db77"  #0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-C.patch
         "720339a269c42c41daaf805c7265e8b0"  #0001-zstd-patches.patch
         "bca862bdbb3b677e6407c542622072bf"  #0001-zstd-dev-patches.patch
         "d6b3bcd857e74530a9d0347c6dc05c13"  #0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch
         "1e7a53eae980951494ee630853d39d98"  #0002-mm-Support-soft-dirty-flag-read-with-reset.patch
         "17de5f1bddeceae825b0a009ef9837d8"  #0001-LL-kconfig-add-750Hz-timer-interrupt-kernel-config-o.patch
         "22baa0b09b2604e1331f4d02e73bfd16"  #0003-sched-core-nr_migrate-256-increases-number-of-tasks-.patch
         "01174db38e680ab4c3816555f27dee41"  #0004-mm-set-8-megabytes-for-address_space-level-file-read.patch
         "388d99168ebf40c7b377715f07e41b25"  #0005-Disable-CPU_FREQ_GOV_SCHEDUTIL.patch
         "168a924c7c83ecdc872a9a1c6d1c8bdb"  #0006-add-acs-overrides_iommu.patch
         "27e6001bacfcfca1c161bf6ef946a79b") #vm.max_map_count.patch
#zenify workarround with CacULE
if [[ $_cpu_sched != "1" ]] && [[ $_cpu_sched != "2" ]]; then
 source+=("$patchsource/misc-patches/zenify.patch")
 md5sums+=("8e71f0c43157654c4105224d89cc6709")  #zenify.patch
fi
if [[ $_cpu_sched = "1" ]] || [[ $_cpu_sched = "2" ]]; then
  source+=("${patchsource}/cacule-patches/cacule-$major.patch"
           "${patchsource}/cacule-patches/0002-cacule-Change-default-preemption-latency-to-2ms-for-.patch"
           "${patchsource}/cacule-patches/0003-cacule-Set-cacule_harsh_mode-enabled-by-default.patch")
  md5sums+=("ff3696980dc9846c6c86cff9ae364b14"  #cacule-5.12.patch
            "cdf2d612b6c1234ce124f0e8361fdc2e"  #0002-cacule-Change-default-preemption-latency-to-2ms-for-.patch
            "09ca141fe7aff2a0f426e1d79f45aba3") #0003-cacule-Set-cacule_harsh_mode-enabled-by-default.patch
elif [[ $_cpu_sched = "3" ]] || [[ $_cpu_sched = "4" ]]; then
  source+=("${patchsource}/prjc-patches/0009-prjc_v$major-r0.patch")
  md5sums+=("7abf23bacb8274a97299cf9d89ead04a")  #0009-prjc_v5.12-r0.patch
elif [[ $_cpu_sched = "5" ]]; then
  source+=("${patchsource}/muqss-patches/patch-$major-ck1")
  md5sums+=("8390ad22d4fff62945741b45e4385d02")  #patch-5.12-ck1
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

  # patch command for muqss
  if [[ $_cpu_sched = "5" ]]; then
    msg2 "Applying patch patch-$major-ck1"
    patch -Np1 < ../patch-$major-ck1
  fi

  # Copy the config file first
  # Copy "${srcdir}"/config to linux-${pkgver}/.config
  msg2 "Copy "${srcdir}"/config to linux-$pkgver/.config"
  cp "${srcdir}"/config-$major .config

  # Customize the kernel
  source "${startdir}"/prepare

  configure

  cpu_arch

  # Automation building with rapid_config
  # Uncomment rapid_config and comment out configure and cpu_arch
  # rapid_config is meant to work with build.sh for automation building
  #rapid_config

  # strip_down script
  #strip_down

  # fix for GCC 12.0.0 (git version)
  # plugins don't work
  # disable plugins 
  #scripts/config --disable HAVE_GCC_PLUGINS
  #scripts/config --disable GCC_PLUGINS

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
