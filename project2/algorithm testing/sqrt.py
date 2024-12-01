import math
#def squareRoot(n, l) :
 
    # Assuming the sqrt of n as n only 
#    root = int(n/2) + 1
 
#    for _ in range(0, l):
 
        # Calculate more closed x 
#        root = int(0.5 * (root + (n / root)))
 
#    return root


def babyRoot(n):
    # simplifying as much as possible for translation into assembly
    # 4 attempts gets us within 1 of the true sqrt(n) for any number < 360 < 2^9
    # 8 attempts gets the same bound for n < 31323 < 2^15
    # 15 attempts works for n < 166642245 < 2^28
    # 18 attempts for n < 27245463552 < 2^35
    # 20 attempts for n < 98709700608 < 2^37
    # 35 attempts for n < ? < n^65


    root = n//2 + 1
    for _ in range(0,35):
        root = (((n // root) + root) // 2)

    
    return root



 
for i in range(int(math.pow(2, 64)), int(math.pow(2, 65))):
    print("\r", i, end="")
    br = babyRoot(i)
    real = math.sqrt(i)
    if ((br > real + 1) or (br < real - 1)):
        print("\nBroken at", i, "=", math.log2(i))
        break
