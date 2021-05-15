#!/usr/bin/bash

# gcc build

makepkg -s

rm -rf pkg/ src/

env _cpu_sched=1 makepkg -s

rm -rf pkg/ src/

env _cpu_sched=2 makepkg -s

rm -rf pkg/ src/

env _cpu_sched=3 makepkg -s

rm -rf pkg/ src/

env _cpu_sched=4 makepkg -s

rm -rf pkg/ src/

env _cpu_sched=5 makepkg -s

rm -rf pkg/ src/

# clang build

env _compiler=2 makepkg -s

rm -rf pkg/ src/

env _cpu_sched=1 _compiler=2 makepkg -s

rm -rf pkg/ src/

env _cpu_sched=2 _compiler=2 makepkg -s

rm -rf pkg/ src/

env _cpu_sched=3 _compiler=2 makepkg -s

rm -rf pkg/ src/

env _cpu_sched=4 _compiler=2 makepkg -s

rm -rf pkg/ src/

env _cpu_sched=5 _compiler=2 makepkg -s

rm -rf pkg/ src/
