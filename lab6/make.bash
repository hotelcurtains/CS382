#!/bin/bash
#aarch64-linux-gnu-as demo.s -g -o demo.o
#aarch64-linux-gnu-ld demo.o
#qemu-aarch64 -g 1234 a.out

aarch64-linux-gnu-as demo.s -o demo.o
aarch64-linux-gnu-ld demo.o -lc
qemu-aarch64 -L /usr/aarch64-linux-gnu/ a.out