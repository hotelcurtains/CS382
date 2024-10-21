#!/bin/bash
aarch64-linux-gnu-as atoi.s -g -o atoi.o
aarch64-linux-gnu-as atoi_data.s -g -o atoi_data.o
aarch64-linux-gnu-ld atoi.o atoi_data.o
qemu-aarch64 -g 1235 a.out

#aarch64-linux-gnu-as bins.s -o bins.o
#aarch64-linux-gnu-as bins_data.s -o bins_data.o
#aarch64-linux-gnu-ld bins.o bins_data.o -o bins
#qemu-aarch64 bins