#!/bin/bash
aarch64-linux-gnu-as task2.s -o demo.o
aarch64-linux-gnu-ld demo.o -lc
qemu-aarch64 -L /usr/aarch64-linux-gnu a.out
rm demo.o
rm a.out