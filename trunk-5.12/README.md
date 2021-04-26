# Linux

Linux kernel build for Archlinux with a patch set by TK-Glitch, Piotr Górski, Hamad Al Marri, Con Kolivas and Alfred Chen.

# Version

### Linux kernel

- 5.12

# Build

### Build Linux kernel

    git clone https://github.com/kevall474/Linux.git
    cd Linux
    env _cpu_sched=(1 or 2) _compiler=(1 or 2) makepkg -s

# Build variables

### _cpu_sched

- Will add a CPU Scheduler if you want :

        1 : CacULE by Hamad Al Marri
        2 : CacULE-RDB by Hamad Al Marri

Leave this variable empty if you don't want to add a CPU Scheduler.

### _compiler

- Will set compiler to build the kernel :

        1 : GCC
        2 : CLANG+LLVM

If not set it will build with GCC by default.

# Troubleshooting

### The system isn't booting with the compiled kernel used a custom llvm/clang version

- If you're compiling with llvm-rc or llvm-git be sure to recompile the mesa-* lib32-mesa-* packages against it.
- Systems with intel/nvidia graphics just need to compile them with env _compiler=(1 or 2) makepkg -s | _compiler=1 ==> GCC  _compiler=2 ==> CLANG
- Systems with AMD graphics need to compile with env _llvm=y _compiler=(1 or 2) makepkg -s | _compiler=1 ==> GCC  _compiler=2 ==> CLANG | _llvm=y is optional. It's to enable LLVM by default since ACO is the default shader compiler.
- After compiling install both packages with sudo pacman -U mesa-*.pkg.zst lib32-mesa-*.pkg.zst

You will find the following packages here:
- https://github.com/kevall474/LLVM
- https://github.com/kevall474/Mesa


# CPU Scheduler

## CacULE CPU Scheduler

![cacule_sched](https://user-images.githubusercontent.com/68618182/103179297-92ac0100-4858-11eb-83aa-8992f33d67f8.png)

CacULE is a newer version of Cachy. The CacULE CPU scheduler is based on interactivity score mechanism.
The interactivity score is inspired by the ULE scheduler (FreeBSD scheduler).

About CacULE Scheduler

- Each CPU has its own runqueue.
- NORMAL runqueue is a linked list of sched_entities (instead of RB-Tree).
- RT and other runqueues are just the same as the CFS's.
- Wake up tasks preempt currently running tasks if its interactivity score value is higher.

# Update GRUB

    sudo grub-mkconfig -o /boot/grub/grub.cfg

# Contact info

kevall474@tuta.io if you have any problems or bugs report.

# Info

You can refer to this Archlinux page that have lots of useful information to build the kernel and debugging if you have some issues https://wiki.archlinux.org/index.php/Kernel/Traditional_compilation
