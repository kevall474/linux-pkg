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
#Set '5' for MuQSS CPUC Scheduler
#Leave empty for no CPU Scheduler
#Default is empty. It will build with no cpu scheduler. To build with cpu shceduler just use : env _cpu_sched=(1,2,3,4 or 5) makepkg -s
if [ -z ${_cpu_sched+x} ]; then
  _cpu_sched=
fi

################################# Arch ################################

ARCH=x86

################################# GCC ################################

# Grap GCC version
# Workarround with GCC 12.0.0. Pluggins don't work, so we have to grap GCC version
# and disable CONFIG_HAVE_GCC_PLUGINS/CONFIG_GCC_PLUGINS

GCC_VERSION=$(gcc -dumpversion)

################################# CC/CXX/HOSTCC/HOSTCXX ################################

#Set compiler to build the kernel
#Set '1' to build with GCC
#Set '2' to build with CLANG and LLVM
#Default is empty. It will build with GCC. To build with different compiler just use : env _compiler=(1 or 2) makepkg -s
if [ -z ${_compiler+x} ]; then
  _compiler=
fi

if [[ "$_compiler" = "1" ]]; then
  _compiler=1
  CC=gcc
  CXX=g++
  HOSTCC=gcc
  HOSTCXX=g++
elif [[ "$_compiler" = "2" ]]; then
  _compiler=2
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
pkgver=5.13.1
major=5.13
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
        "$patchsource/bbr2-patches/0001-bbr2-patches.patch"
        "$patchsource/bcachefs-patches/0001-bcachefs-5.13-introduce-bcachefs-patchset.patch"
        "$patchsource/block-patches/0001-block-patches.patch"
        "$patchsource/bfq-patches/0001-bfq-patches.patch"
        "$patchsource/btrfs-patches/0001-btrfs-patches.patch"
        "$patchsource/clearlinux-patches/0001-clearlinux-patches.patch"
        "$patchsource/cpu-patches/0001-cpu-5.13-merge-graysky-s-patchset.patch"
        "$patchsource/cpu-patches/0002-init-Kconfig-enable-O3-for-all-arches.patch"
        "$patchsource/cpu-patches/0003-init-Kconfig-add-O1-flag.patch"
        "$patchsource/cpu-patches/0001-Makefile-Turn-off-loop-vectorization-for-GCC-O3-opti.patch"
        "https://raw.githubusercontent.com/kevall474/kernel-patches/main/5.12/compaction-patches/0001-compaction-patches.patch"
        "$patchsource/futex-patches/0001-futex-resync-from-gitlab.collabora.com.patch"
        "$patchsource/futex-tkg-patches/0007-v5.13-futex2_interface.patch"
        "$patchsource/ksm-patches/0001-ksm-patches.patch"
        "$patchsource/loopback-patches/0001-v4l2loopback-patches.patch"
        "$patchsource/lqx-patches/0001-zen-Allow-MSR-writes-by-default.patch"
        "$patchsource/ntfs3-patches/0001-ntfs3-patches.patch"
        "$patchsource/pf-patches/0001-pf-patches.patch"
        "$patchsource/security-patches/0001-security-patches.patch"
        "$patchsource/wine-patches/0007-v5.13-winesync.patch"
        "$patchsource/xanmod-patches/0005-XANMOD-kconfig-set-PREEMPT-and-RCU_BOOST-without-del.patch"
        "$patchsource/xanmod-patches/0006-XANMOD-dcache-cache_pressure-50-decreases-the-rate-a.patch"
        "$patchsource/xanmod-patches/0007-XANMOD-sched-autogroup-Add-kernel-parameter-and-conf.patch"
        "$patchsource/xanmod-patches/0008-XANMOD-mm-vmscan-vm_swappiness-30-decreases-the-amou.patch"
        "$patchsource/xanmod-patches/0009-XANMOD-cpufreq-tunes-ondemand-and-conservative-gover.patch"
        "$patchsource/xanmod-patches/0011-XANMOD-lib-kconfig.debug-disable-default-CONFIG_SYMB.patch"
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
md5sums=("6499bdaa4ee1ef873ffd6533492140e7"  #linux-5.13.1.tar.xz
         "e7934271b7973cee2619aff94cf3265a"  #config-5.13
         "1bd37d8e71b2a7aae8ebd2853a08f445"  #0001-bbr2-patches.patch
         "f9dd96a59d6a84e451736e697a897227"  #0001-bcachefs-5.13-introduce-bcachefs-patchset.patch
         "396c84c4a6557db27f9c3bbfa656ac3e"  #0001-block-patches.patch
         "e16eb528e701193bc8cb1facc6b27231"  #0001-bfq-patches.patch
         "63078800040b2a9a9f19c59c4ebf5b23"  #0001-btrfs-patches.patch
         "c360b8c17d778f98a54fa7cddf348566"  #0001-clearlinux-patches.patch
         "b1d52157c29773e899658676b5e3a3d0"  #0001-cpu-5.13-merge-graysky-s-patchset.patch
         "97e4bafc4d830edf8dccad7bc93de748"  #0002-init-Kconfig-enable-O3-for-all-arches.patch
         "9ed92b6421a4829c3be67af8e4b65a04"  #0003-init-Kconfig-add-O1-flag.patch
         "2fcfcb4812de779f21915d918f1fcee6"  #0001-Makefile-Turn-off-loop-vectorization-for-GCC-O3-opti.patch
         "98564f54c3f9a6da56c6156d26b3ea39"  #0001-compaction-patches.patch
         "85f4be6562ee033b83814353a12b61bd"  #0001-futex-resync-from-gitlab.collabora.com.patch
         "2c0375b3cc9690a0f0f3d3e49df54d10"  #0007-v5.13-futex2_interface.patch
         "ce9beff503ee9e6ce6fd983c1bbbdd9e"  #0001-ksm-patches.patch
         "ef7748efcae55f7db8961227cbae3677"  #0001-v4l2loopback-patches.patch
         "09a9e83b7b828fae46fd1a4f4cc23c28"  #0001-zen-Allow-MSR-writes-by-default.patch
         "86825a0c5716a1d9c6a39f9d3886b1bf"  #0001-ntfs3-patches.patch
         "ed46a39e062f07693f52981fbd7350b7"  #0001-pf-patches.patch
         "9977ba0e159416108217a45438ebebb4"  #0001-security-patches.patch
         "9573b92353399343db8a691c9b208300"  #0007-v5.13-winesync.patch
         "d8175b0627547ea30279974a2e33bdaa"  #0005-XANMOD-kconfig-set-PREEMPT-and-RCU_BOOST-without-del.patch
         "93c22703a564720ec2eeb0f73886668b"  #0006-XANMOD-dcache-cache_pressure-50-decreases-the-rate-a.patch
         "30085a2ceb79ed6c8e97c25311d62456"  #0007-XANMOD-sched-autogroup-Add-kernel-parameter-and-conf.patch
         "45e37e9feb1010271d6c537a3c2f3bf5"  #0008-XANMOD-mm-vmscan-vm_swappiness-30-decreases-the-amou.patch
         "3888cc476245e851b5b597445f2f4b4e"  #0009-XANMOD-cpufreq-tunes-ondemand-and-conservative-gover.patch
         "89af44f9f637af84564bc6a3a3f39894"  #0011-XANMOD-lib-kconfig.debug-disable-default-CONFIG_SYMB.patch
         "6130dd0033e44e9ee3cacbbfe578ff06"  #0001-ZEN-Add-VHBA-driver.patch
         "8a9f82e7cbac3eb60ff23ab7221625ad"  #0003-ZEN-vhba-Update-to-20210418.patch
         "55ae1e0dd0d7024a3e825a4468d87e50"  #0002-ZEN-intel-pstate-Implement-enable-parameter.patch
         "9bb46b8ce45259c238c5233b8394d70b"  #0001-ZEN-Add-sysctl-and-CONFIG-to-disallow-unprivileged-C.patch
         "b79559e409253824cf6c569dfe9a7d7f"  #0001-zstd-patches.patch
         "24e975eef21cfdabfab86d80d19a1f83"  #0001-zstd-dev-patches.patch
         "d6b3bcd857e74530a9d0347c6dc05c13"  #0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch
         "1e7a53eae980951494ee630853d39d98"  #0002-mm-Support-soft-dirty-flag-read-with-reset.patch
         "b179a695ab935d7a7c159f8f8bcd3f01"  #0001-LL-kconfig-add-750Hz-timer-interrupt-kernel-config-o.patch
         "b3388af517abd48879b7890dae935286"  #0003-sched-core-nr_migrate-256-increases-number-of-tasks-.patch
         "26be410fdc6d7c4f4e122a74fda6f96b"  #0004-mm-set-8-megabytes-for-address_space-level-file-read.patch
         "8d51ee9dd00a1b0c75dc076b4710d5ca"  #0005-Disable-CPU_FREQ_GOV_SCHEDUTIL.patch
         "168a924c7c83ecdc872a9a1c6d1c8bdb"  #0006-add-acs-overrides_iommu.patch
         "27e6001bacfcfca1c161bf6ef946a79b") #vm.max_map_count.patch

# 0001-mm-5.13-protect-file-mappings-under-memory-pressure.patch workarround with MuQSS
#if [[ $_cpu_sched != "5" ]]; then
  #source+=("$patchsource/mm-patches/0001-mm-5.13-protect-file-mappings-under-memory-pressure.patch")
  #md5sums+=("d27d970188b39b775830a86472cda673")  #0001-mm-5.13-protect-file-mappings-under-memory-pressure.patch
#fi

# 0005-XANMOD-kconfig-set-PREEMPT-and-RCU_BOOST-without-del.patch workarround with MuQSS
#if [[ $_cpu_sched != "5" ]]; then
  #source+=("$patchsource/xanmod-patches/0005-XANMOD-kconfig-set-PREEMPT.patch")
  #md5sums+=("SKIP")
#fi

# 0008-XANMOD-mm-vmscan-vm_swappiness-30-decreases-the-amou.patch workarround with MuQSS
#if [[ $_cpu_sched != "5" ]]; then
  #source+=("$patchsource/xanmod-patches/0008-XANMOD-mm-vmscan-vm_swappiness-30-decreases-the-amou.patch")
  #md5sums+=("45e37e9feb1010271d6c537a3c2f3bf5")  #0008-XANMOD-mm-vmscan-vm_swappiness-30-decreases-the-amou.patch
#fi

# 0014-XANMOD-fair-Remove-all-energy-efficiency-functions.patch workarround with CaCULE
if [[ $_cpu_sched != "1" ]] && [[ $_cpu_sched != "2" ]]; then
  source+=("$patchsource/xanmod-patches/0014-XANMOD-fair-Remove-all-energy-efficiency-functions.patch")
  md5sums+=("75e2d936e50f00bf3860385846cceb9a")  #0014-XANMOD-fair-Remove-all-energy-efficiency-functions.patch
fi

# zenify workarround with CacULE
if [[ $_cpu_sched != "1" ]] && [[ $_cpu_sched != "2" ]]; then
  source+=("$patchsource/misc-patches/zenify.patch")
  md5sums+=("dbeccd72f6b3d8245a216b572780e170")  #zenify.patch
fi

# CacULE patch
if [[ $_cpu_sched = "1" ]] || [[ $_cpu_sched = "2" ]]; then
  source+=("${patchsource}/cacule-patches/cacule-$major.patch"
           "$patchsource/xanmod-patches/0002-XANMOD-cacule-remove-delta-since-it-is-not-used.patch")
  md5sums+=("8fab6f0acf86d138a283c4dd044198ed"  #cacule-5.13.patch
            "2dd03c0bfc68441eff4f71713738ea57") #0002-XANMOD-cacule-remove-delta-since-it-is-not-used.patch
fi

# prjc patch
if [[ $_cpu_sched = "3" ]] || [[ $_cpu_sched = "4" ]]; then
  source+=("${patchsource}/prjc-patches/prjc_v$major-r1.patch")
  md5sums+=("887404c001eee64ee281a1607f895d63")  #prjc_v5.13-r1.patch
fi

# MuQSS patch. Apply patch-5.12-ck1 with 5.13 kernel. The patch is forced because there is no release from Con Kolivas
# for 5.13 kernel. Bugs in the kernel may occur.
if [[ $_cpu_sched = "5" ]]; then
  source+=("${patchsource}/muqss-patches/0001-MultiQueue-Skiplist-Scheduler-v0.210.patch")
  md5sums+=("SKIP")
fi
  
# rdb patch
if [[ $_cpu_sched = "2" ]]; then
  source+=("${patchsource}/cacule-patches/rdb-$major.patch")
  md5sums+=("efb4f07f10058ec12933ba3ea12aa983")  #rdb-5.13.patch
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

  # Apply MuQSS patch
  #if [[ $_cpu_sched = "5" ]]; then
    #msg2 "Applying patch patch-$major-ck1"
    #patch -Np1 < ../patch-$major-ck1
    # Apply patch-5.12-ck1 with 5.13 kernel. The patch is forced because there is no release from Con Kolivas
    # for 5.13 kernel. Bugs in the kernel may occur. Patch renamed to patch-5.13-pre-release.
    #msg2 "Apply patch-5.12-ck1 with 5.13 kernel. The patch is forced because there"
    #msg2 "is no release from Con Kolivas for 5.13 kernel. Bugs in the kernel may occur"
    #patch -Np1 --force < ../patch-$major-pre-release || true
  #fi

  # Copy the config file first
  # Copy "${srcdir}"/config-$major to "${srcdir}"/linux-${pkgver}/.config
  msg2 "Copy "${srcdir}"/config-$major to "${srcdir}"/linux-$pkgver/.config"
  cp "${srcdir}"/config-$major .config

  # Disable LTO
  if [[ "$_compiler" = "1" ]] || [[ "$_compiler" = "2" ]]; then
    plain ""
    msg2 "Disable LTO"
    scripts/config --disable CONFIG_LTO
    scripts/config --disable CONFIG_LTO_CLANG
    scripts/config --disable CONFIG_ARCH_SUPPORTS_LTO_CLANG
    scripts/config --disable CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN
    scripts/config --disable CONFIG_HAS_LTO_CLANG
    scripts/config --disable CONFIG_LTO_NONE
    scripts/config --disable CONFIG_LTO_CLANG_FULL
    scripts/config --disable CONFIG_LTO_CLANG_THIN
    sleep 2s
  fi

  # fix for GCC 12.0.0 (git version)
  # plugins don't work
  # disable plugins
  #if [[ "$GCC_VERSION" = "12.0.0" ]] && [[ "$_compiler" = "1" ]]; then
  #  plain ""
  #  msg2 "Disable CONFIG_HAVE_GCC_PLUGINS/CONFIG_GCC_PLUGINS (Quick fix for gcc 12.0.0 git version)"
  #  scripts/config --disable CONFIG_HAVE_GCC_PLUGINS
  #  scripts/config --disable CONFIG_GCC_PLUGINS
  #  plain ""
  #  sleep 2s
  #fi

  # Customize the kernel
  source "${startdir}"/prepare

  configure

  cpu_arch

  # Automation building with rapid_config
  # Uncomment rapid_config and comment out configure and cpu_arch
  # rapid_config is meant to work with build.sh for automation building
  #rapid_config

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

  cd "${srcdir}"/linux-$pkgver

  # make -j$(nproc) all
  msg2 "make -j$(nproc) all..."
  if [[ "$_compiler" = "1" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} -j$(nproc) all
  elif [[ "$_compiler" = "2" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} -j$(nproc) all
  fi
}

_package(){
  pkgdesc="Latest stable linux kernel and modules with a set of patches by TK-Glitch and Piotr Górski"
  depends=("coreutils" "kmod" "initramfs" "mkinitcpio")
  optdepends=("linux-firmware: firmware images needed for some devices"
              "crda: to set the correct wireless channels of your country"
              "winesync-headers: headers file for winesync module")
  provides=("VIRTUALBOX-GUEST-MODULES" "WIREGUARD-MODULE")

  cd "${srcdir}"/linux-$pkgver

  local kernver="$(<version)"
  local modulesdir="${pkgdir}"/usr/lib/modules/${kernver}

  msg2 "Installing boot image..."
  # systemd expects to find the kernel here to allow hibernation
  # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab8128dcf99161d2344
  #install -Dm644 arch/${ARCH}/boot/bzImage "$modulesdir/vmlinuz"
  msg2 "install -Dm644 "$(make -s image_name)" "$modulesdir/vmlinuz""
  install -Dm644 "$(make -s image_name)" "$modulesdir/vmlinuz"

  # Used by mkinitcpio to name the kernel
  msg2 "echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase""
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

  cd "${srcdir}"/linux-$pkgver

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

  # https://bugs.archlinux.org/task/13146
  install -Dt "$builddir/drivers/media/i2c" -m644 drivers/media/i2c/msp3400-driver.h

  # https://bugs.archlinux.org/task/20402
  install -Dt "$builddir/drivers/media/usb/dvb-usb" -m644 drivers/media/usb/dvb-usb/*.h
  install -Dt "$builddir/drivers/media/dvb-frontends" -m644 drivers/media/dvb-frontends/*.h
  install -Dt "$builddir/drivers/media/tuners" -m644 drivers/media/tuners/*.h

  # https://bugs.archlinux.org/task/71392
  install -Dt "$builddir/drivers/iio/common/hid-sensors" -m644 drivers/iio/common/hid-sensors/*.h

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
