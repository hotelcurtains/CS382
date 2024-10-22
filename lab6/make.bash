#!/bin/bash
aarch64-linux-gnu-as lab6_starter.s -o -g lab6_starter.o
aarch64-linux-gnu-ld -lc lab6_starter.o
qemu-aarch64 -L /usr/aarch64-linux-gnu -g 1234 a.out 