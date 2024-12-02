# Author: Daniel Detore

import sys

if (len(sys.argv) > 2):
    print("BROKEN")

filename = sys.argv[1]
if (".s" not in filename):
    filename += ".s"

source = open(filename, "r")

lines = source.readlines()
source.close()
output = open(filename[:-2]+".txt", "w")

for line in lines:
    line = line[:line.find("//")].strip().upper()
    if (line == ""): 
        continue
    if (line == "EN"): 
        break
    output.write(line + "\n")






output.close()