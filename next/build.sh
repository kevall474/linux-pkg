#!/usr/bin/bash

# gcc build

makepkg -s

rm -rf pkg/ src/

# clang build

env _compiler=2 makepkg -s

rm -rf pkg/ src/
