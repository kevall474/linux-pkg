# Linux-Kernel-Builder

Linux kernel build for Archlinux with a patch-set by TK-Glitch, Piotr Górski, Hamad Al Marri, Con Kolivas and Alfred Chen.

## Versions

### Linux kernel

- 5.11.7

### XanMod kernel

- 5.11.7-xanmod1

### linux-api-headers (git version)

- 5.12

# How-to

## Build Linux kernel

    git clone https://github.com/kevall474/Linux.git
    cd Linux/Linux
    env _cpu_sched=(1,2,3,4,5 or 6) _compiler=(1,2,3 or 4) makepkg -s

### Install

    sudo pacman -U linux-kernel-(optional if cpu sched selected : muqss,bmq,pds,cacule,upds)
    sudo pacman -U linux-kernel-(optional if cpu sched selected : muqss,bmq,pds,caule,upds)-headers

## Build xanmod-linux kernel

    git clone https://github.com/kevall474/Linux.git
    cd Linux/XanMod
    env _compiler=(1,2,3 or 4) makepkg -s

### Install

    sudo pacman -U xanmod-kernel xanmod-kernel-headers

## Build linux-api-headers

    git clone https://github.com/kevall474/Linux.git
    cd Linux
    cd linux-api-headers
    makepkg -si

# Build options/variables

## Linux kernel

### _cpu_sched

- Will add a CPU Scheduler if you want :

        1 : MuQSS by Con Kolivas
        2 : BMQ by Alfred Chen
        3 : PDS by Alfred Chen
        4 : CacULE by Hamad Al Marri
        5 : UPDS by TK-Glitch
        6 : CacULE-RDB by Hamad Al Marri

Leave this variable empty if you don't want to add a CPU Scheduler.

### _compiler

- Will set compiler to build the kernel :

        1 : GCC
        2 : GCC+LLVM
        3 : CLANG
        4 : CLANG+LLVM

If not set it will build with GCC by default.

## XanMod kernel

### _compiler

- Will set compiler to build the kernel :

        1 : GCC
        2 : GCC+LLVM
        3 : CLANG
        4 : CLANG+LLVM

If not set it will build with GCC by default.

# Troubleshooting

## Common Issues

- Dont forget to update your bootloader --> for example with grub:
`sudo grub-mkconfig -o /boot/grub/grub.cfg`
- On nvidia systems rebuild your mkinitcpio: `sudo mkinitcpio -P`

## The system isn't booting with the compiled kernel used a custom llvm/clang version

- If you're compiling with llvm-rc or llvm-git be sure to recompile the mesa-* lib32-mesa-* packages against it.
- Systems with intel/nvidia graphics just need to compile them with `env _compiler=(1 or 2) makepkg -s | _compiler=1 ==> GCC  _compiler=2 ==> CLAN`
- Systems with AMD graphics need to compile with `env _llvm=y _compiler=(1 or 2) makepkg -s | _compiler=1 ==> GCC  _compiler=2 ==> CLANG | _llvm=y` is optional. It's to enable LLVM by default since ACO is the default shader compiler.
- After compiling install both packages with `sudo pacman -U mesa-*.pkg.zst lib32-mesa-*.pkg.zst`

You will find the following packages here:
- https://github.com/kevall474/LLVM
- https://github.com/kevall474/Mesa


# CPU Scheduler

## MuQSS CPU Scheduler

MuQSS - The Multiple Queue Skiplist Scheduler by Con Kolivas.

MuQSS is a per-cpu runqueue variant of the original BFS scheduler with
one 8 level skiplist per runqueue, and fine grained locking for much more
scalability.

The goal of the Multiple Queue Skiplist Scheduler, referred to as MuQSS from
here on (pronounced mux) is to completely do away with the complex designs of
the past for the cpu process scheduler and instead implement one that is very
simple in basic design. The main focus of MuQSS is to achieve excellent desktop
interactivity and responsiveness without heuristics and tuning knobs that are
difficult to understand, impossible to model and predict the effect of, and when
tuned to one workload cause massive detriment to another, while still being
scalable to many CPUs and processes.

MuQSS is best described as per-cpu multiple runqueue, O(log n) insertion, O(1)
lookup, earliest effective virtual deadline first tickless design, loosely based
on EEVDF (earliest eligible virtual deadline first) and my previous Staircase
Deadline scheduler, and evolved from the single runqueue O(n) BFS scheduler.
Each component shall be described in order to understand the significance of,
and reasoning for it.

## BMQ CPU Scheduler

BitMap Queue CPU scheduler, referred to as BMQ from here on, is an evolution
of previous Priority and Deadline based Skiplist multiple queue scheduler(PDS),
and inspired by Zircon scheduler. The goal of it is to keep the scheduler code
simple, while efficiency and scalable for interactive tasks, such as desktop,
movie playback and gaming etc.

BMQ use per CPU run queue design, each CPU(logical) has it's own run queue,
each CPU is responsible for scheduling the tasks that are putting into it's
run queue.

The run queue is a set of priority queues. Note that these queues are fifo
queue for non-rt tasks or priority queue for rt tasks in data structure. See
BitMap Queue below for details. BMQ is optimized for non-rt tasks in the fact
that most applications are non-rt tasks. No matter the queue is fifo or
priority, In each queue is an ordered list of runnable tasks awaiting execution
and the data structures are the same. When it is time for a new task to run,
the scheduler simply looks the lowest numbered queueue that contains a task,
and runs the first task from the head of that queue. And per CPU idle task is
also in the run queue, so the scheduler can always find a task to run on from
its run queue.

Each task will assigned the same timeslice(default 4ms) when it is picked to
start running. Task will be reinserted at the end of the appropriate priority
queue when it uses its whole timeslice. When the scheduler selects a new task
from the priority queue it sets the CPU's preemption timer for the remainder of
the previous timeslice. When that timer fires the scheduler will stop execution
on that task, select another task and start over again.

If a task blocks waiting for a shared resource then it's taken out of its
priority queue and is placed in a wait queue for the shared resource. When it
is unblocked it will be reinserted in the appropriate priority queue of an
eligible CPU.

BMQ supports DEADLINE, FIFO, RR, NORMAL, BATCH and IDLE task policy like the
mainline CFS scheduler. But BMQ is heavy optimized for non-rt task, that's
NORMAL/BATCH/IDLE policy tasks.

## PDS CPU Scheduler

Priority and Deadline based Skiplist multiple queue scheduler, referred to as
PDS from here on, is developed upon the enhancement patchset VRQ(Variable Run
Queue) for BFS(Brain Fuck Scheduler by Con Kolivas). PDS inherits the existing
design from VRQ and inspired by the introduction of skiplist data structure
to the scheduler by Con Kolivas. However, PDS is different from MuQSS(Multiple
Queue Skiplist Scheduler, the successor after BFS) in many ways.

PDS is designed to make the cpu process scheduler code to be simple, but while
efficiency and scalable. Be Simple, the scheduler code will be easy to be read
and the behavious of scheduler will be easy to predict. Be efficiency, the
scheduler shall be well balance the thoughput performance and task interactivity
at the same time for different properties the tasks behave. Be scalable, the
performance of the scheduler should be in good shape with the glowing of
workload or with the growing of the cpu numbers.

PDS is described as a multiple run queues cpu scheduler. Each cpu has its own
run queue. A heavry customized skiplist is used as the backend data structure
of the cpu run queue. Tasks in run queue is sorted by priority then virtual
deadline(simplfy to just deadline from here on). In PDS, balance action among
run queues are kept as less as possible to reduce the migration cost. Cpumask
data structure is widely used in cpu affinity checking and cpu preemption/
selection to make PDS scalable with increasing cpu number.

## CacULE CPU Scheduler

![cacule_sched](https://user-images.githubusercontent.com/68618182/103179297-92ac0100-4858-11eb-83aa-8992f33d67f8.png)

CacULE is a newer version of Cachy. The CacULE CPU scheduler is based on interactivity score mechanism.
The interactivity score is inspired by the ULE scheduler (FreeBSD scheduler).

About CacULE Scheduler

- Each CPU has its own runqueue.
- NORMAL runqueue is a linked list of sched_entities (instead of RB-Tree).
- RT and other runqueues are just the same as the CFS's.
- Wake up tasks preempt currently running tasks if its interactivity score value is higher.

## CacULE - Response Driven Balancer (RDB)
This is an experimental load balancer for Cachy/CacULE. It is a lightweight
load balancer which is a replacement of CFS load balancer. It migrates
tasks based on their HRRN/Interactivity Scores (IS). Most of CFS load balancing-related
updates (cfs and se updates loads) are removed. The RDB balancer follows CFS
paradigm in which RDB balancing happen at the same points CFS does. RDB balancing happens
in three functions: `newidle_balance`, `idle_balance`, and `active_balance`. The `newidle_balance`
is called exactly at the same time as CFS did (when pick next task fails to find any task to run).
The RDB `newidle_balance` pulls one task that is the highest HRRN/IS from any CPU. The RDB `idle_balance`
is called in `trigger_load_balance` when CPU is idle, it does the same as `newidle_balance` but with
slight changes since `newidle_balance` is a special case. The RDB `active_balance` checks if the current
(NORMAL) runqueue has one task, if so, it pulls the highest of the highest HRRN/IS among all other CPUS. If the
runqueue has more than one task, then it pulls any highest HRRN/IS (same as idle does). A CPU cannot pull a task
from another CPU that has fewer tasks (when pull any). For the all three balancing
`newidle_balance`, `idle_balance`, and `active_balance`, the cpu first tries to pull from a CPU that shares the same
cache (`cpus_share_cache`). If can't pull any then it tries to pull from any CPU even though they are not in the same core.
Only when pulling the highest of the highest HRRN/IS (i.e. `active_balance` when CPU has one task), there is no check for
shared cache.

Since `trigger_load_balance` is called for every tick, there is a guard time to prevent frequent tasks migration to reduce
runqueues locking and to reduce unnecessary tasks migrations. The time is `3ms` after each `active_balance`. This time
guard is specifically for HZ=500,1000. We don't want to run balancing every 2ms or 1ms to prevent regression in performance.
Here is how frequent the `trigger_load_balance` would run balancer with given HZ values:
* HZ=100 runs every ~10ms
* HZ=250 runs every ~4ms
* HZ=300 runs every ~3ms
* HZ=500 runs every ~4ms
* HZ=1000 runs every ~3ms

# Update GRUB

    sudo grub-mkconfig -o /boot/grub/grub.cfg

# Contact info

kevall474@tuta.io if you have any problems or bugs report.

# Credits:

- Linus Torvalds ---> For the linux kernel
- Piotr Gorski <lucjan.lucjanov@gmail.com> <https://github.com/sirlucjan/kernel-patches> ---> For the patches and the base pkgbuild
- Tk-Glitch <https://github.com/Tk-Glitch> ---> For some patches. base PKGBUILD and prepare script
- Con Kolivas <kernel@kolivas.org> <http://ck.kolivas.org/> ---> For MuQSS patches
- Hamad Al Marri <https://github.com/hamadmarri/cachy-sched> ---> For CacULE CPU Scheduler patch
- Alfred Chen <https://gitlab.com/alfredchen/projectc> ---> For the BMQ/PDS CPU Scheduler patch
- Credits: Joan Figueras <ffigue at gmail dot com> ---> For the base PKGBUILD
- Credits: Andreas Radke <andyrtr@archlinux.org> ---> For the base PKGBUILD
- Credits: Jan Alexander Steffens (heftig) <heftig@archlinux.org> ---> For the base PKGBUILD

# Info

You can refer to this Archlinux page that have lots of useful information to build the kernel and debugging if you have some issues https://wiki.archlinux.org/index.php/Kernel/Traditional_compilation
