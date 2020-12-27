# linux-pkg

Linux kernel build for Archlinux with a patch set by TK-Glitch, Piotr Górski, Hamad Al Marri and, Con Kolivas and Alfred Chen. 

# Version

- stable : 5.10.3
- mainline : 5.10-rc7

# Build 

    git clone https://github.com/kevall474/linux-pkg
    cd linux-pkg
    env _release=(1 or 2) _cpu_sched=(1,2,3,4,5 or 6) _compiler=(1,2,3 or 4) makepkg -s

## Build variables

### _release

- Will select the release of the kernel :

        1 : Latest stable release
        2 : Latest mainline release

### _cpu_sched

- Will add a CPU Scheduler if you want : Cachy, CacULE, MuQSS, BMQ, PDS or UPDS.

        1 : Cachy by Hamad Al Marri
        2 : CacULE by Hamad Al Marri
        3 : MuQSS by Con Kolivas
        4 : BMQ by Alfred Chen
        5 : PDS by Alfred Chen
        6 : UPDS by TK-Glitch based on the work by Alfred Chen

### _compiler

- Will set compiler to build the kernel :

        1 : GCC
        2 : GCC+LLVM
        3 : CLANG
        4 : CLANG+LLVM
 
