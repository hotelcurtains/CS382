1-time 3-day extension, no questions asked. submit the form on canvas at least a few horus before the deadline.

data sizes for 64-bit systems:

![common data sizes for 64-bit systems](image.png)

- MSB = most significant bit
- LSB = least significant bit
- to turn part of an unsigned byte into a full byte, you do zero extension which is just adding zeros in the most significant place until it's 8 bits long
- unsigned bits have a range of [0, 255]
- for signed numbers
  - have a range of [127, -128]
  - the most significant bit is actually negative, then you add the rest together like normal
  - the signed bit is NOT just a negative sign; it is a place with a negative value
  - we know if a number is signed or not from context, there is nothing in the number that nets us know
    - for a number with a leading 0 it doesn't matter; 0100 = 4 whether it's signed or unsigned
    - we only need to worry if it leads with a 1; 1011 = 11 or -5
- for a signed number with d bits, its range is [-2ᵈ⁻¹ , 2ᵈ⁻¹-1]
- when doing zero extension for signed numbers
  - the most significant bit is changing along with its value so we need to make sure the og value is preserved
    - e.g. 1011 = -5 ≠ 10001011 = -117
  - instead we'll append ones
    - e.g. 1011 = -5 = 11111011 = -5
- so when we do sign extension, we duplicate the MSB to the front
  - therefore zero and sign extension are the same thing, as long as you're dealing with signed numbers
  - for unsigned numbers it needs to always be zeros

# 9/9
- how do we go from +5 to -5?
  - we know for them to be sign opposites, the binary representations of +5 and -5 must add to 0
  - remember two's compliment:
  - +5 = 0101
  - flip all bits: 1010
    - 0101 + 1010 = 1111 = -1
  - add 1: -5 = 1011
    - 0101 + 1011 = 0000 = 0 ✓
  - ∴ 1011 is the two's compliment of 0101
  - from negative back to positive you are still *adding* 1

## shifting
- logical shift left (LSL):
  - take `1011` and shift it left one bit, or `LSL(1)`:
    - we can't shift the MSB left since we only have 4 bits, so we discard it
    - we get `0110`
  - 1011 → LSL(3) → 1000
  - each LSL(n) multiplies the value by 2ⁿ
    - until you shift it out of the byte you have and it becomes 0
  - shifting is much quicker & easier for the computer than multiplication, so sometimes it will rewrite multiplication by powers of 2 as shifting
    - e.g. `a * 8` → `a << 3`
- logical shift right (LSR):
  - same idea; move right, discard anything shifted out of the byte, pad 0s
  - 1011 → LSR(2) → 0010
  - each LSR(n) divides the value by 2ⁿ
- arithmetic shift right (ASR):
  - preserves the MSB (signed or not)
    - still moves it though, then pads with copies of MSB
  - 1011 → ASR(2) → 1110

## logic operators
- &&, ||, ! = and, or, not
  - these are logical operators that produce true/false
- &, |, ~ = and, or, not
  - these are bitwise operators that produce binary numbers from binary numbers
  - performs the operation on each corresponding bit of its operand/s and makes a new number as a result
  - a = 1011
  - b = 0101
  - a & b = 0001
  - a | b = 1111
  - ~a = 0100
- now say we have char a = -5 and char b = 3
  - a = 1111011, b = 00000011
  - a|b = 11111011 = -5
- masking - preserving some bits and setting the rest to 0
  - we only care about, per se, the 3rd 4th and 6th bits of a
  - make a new variable mask = 00110100, with 1s is the places you care about and 0s everywhere else
  - now do `a & mask`
    - it will preserve the bits of mask that are 1 and destroy the 0s
  - can be used to check if a specific bit is 0 or 1 by masking it to only that one bit and checking if it's = 0 or not
    - useful if you are storing a bunch of information in one byte to single out one bit of it

## hexidecimal
- starts with `0x` so we know it's hex
- number contains 0-9 then A-F
- 9 = 1001 = 0x9
- 16 = 1111 = 0xF
- each hex digit represents a nibble (4 bits) of binary
- 1010 1111 1100 = 0xAFC
- 1011111100 → 10 1111 1100 ...
  - we need to extend the first group
  - for that, we need to know if this is signed or not
    - if we don't know then it's over
  - assuming it's unsigned, 0010 1111 1100 = 0x2FC
  - if it's signed, 1110 1111 1100 = 0xEFC
  - there are no negative numbers in hex

# 9/10 lab
- c will translate decimal into binary for you when you assign a value to a variable
- a string in a `char*`
- output by `printf("Hello, %d\n", 382)` = `Hello, 382`
- compile your code with `gcc <some_file>.c -o <name_of_output>`
- run it with `./<name_of_output>`

# 9/11
- carry - the truncated place(s) when unsigned binary addition make a number too big to fit into its size
- positive/negative overflow - truncated place(s) when signed binary addition is too big/small for its size
- byte-addressed memory - every byte in memory has a unique address
  - each byte is between 0 and 2⁶⁴ - 1
- an array's first element is at it's lowest address and then it grows upward
  - the name of the array is a pointer to that first array, in 8 bytes (64-bti addressing)

## C Data Types
- char - one byte; the smallest one
- short int - two bytes / half-word
- int - 4 bytes / word
- float 4 bytes / word
- double - 8 bytes
- long int - 8 bytes
- by default they are all signed
- no strings. use a char array
  - `char str[] = "hello";`
  - by default also contains the null terminator character -- completely invisible

## data type signs
- you can specify `unsigned int` etc.
  - not for double or float
- `unsigned char a = -5` will work, technically
  - it will be interpreted as `a = 1111 1011` 
  - which, when read back, will be interpreted as unsigned so `a = 251`
- `for (unsigned int a = 10; a >= 0; a--){};` will never stop running because sn *unsigned* variable can never be < 0
  - the binary will still wrap around from `00000000` to `11111111`, it just depends on how the computer interprets it

## goto
- `goto` lets us do *un*conditional branching
  - can let us skip around blocks of code
  - give some block of code a label, and whenever you want to use it, call `goto <label>`
- given this:
```c
if (a<0){
  S1;
  S2;
} else{
  S3;
  S4;
}
```
- we can do:
```c
if (a>0) goto La;
// we can get rid of the else condition; 
// it won't reach this line unless "else" happens anyway
goto Lb
La: S1;
S2;
goto Lc
Lb: S3:
S4;
Lc: ...
```
- and this second snippet can be easily translated into assembly later
- now if we have:
```c
for(int a=0; a<10; a++){
  S1;
  S2;
}
```
- this can become:
```c
int a = 0;
Loop: if (a>=10){
  goto Out;
}
S1;
S2;
a++;
goto Loop; 

Out: ...
```

# 9/13 Data Storage

- byte-addressed = 1 byte per address ⇛ amount of unique addresses = amount of bytes that can be stored
- 64-bit implies 2⁶⁴ unique addresses, = amounts of bytes we can store
- range of addresses = [0, 2⁶⁴ - 1]
- every char array used as a string has the amount of characters you give it plus the null terminator
- `char str[]` --> type of `str` = char pointer, `char*`
  - its value is the base address of the first element
- arrays do not have a terminal character
  - they take up only as much data as they contain
- `int arr[]` --> type of `arr` = `int*` to the array's base address
  - the array's next element is ALWAYS the next highest address
- `&` gives you the address of a variable
  - assuming `int arr[] = {10,20,30}` and starts at 0x0
  - `&arr[0]` = 0x0 = `arr` = `arr+0`
    - we get the lowest address, even though 10 takes up the first 4 bytes/addresses by being an int
  - `&arr[1]` = 0x4 = `arr+1`
  - `&arr[2]` = 0x8 = `arr+2`
  - the interpreter knows to move `arr+1` 1 *element* up instead of one *address* up
  - `arr + <n>` is an `int*` just like `arr` by itself
- `*` dereferences a pointer
  - i.e. gives you the value it points to instead of its address
  - `*(arr+0)` = `arr[0]` = 10
  - `*(arr+1)` = `arr[1]` = 20
  - `*(arr+3)` = `arr[2]` = 30
  - `*(arr + <n>)` gives us an int
- we are now never using the good notation again because assembly doesn't have it
- address of the nth element = base address + n * sizeof(data type)
  - this is how `*(arr + <n>)` works
  - if we really only want to move one byte at a time through `int a`, we can do `(char*)&a + <n bytes>`
    - e.g. the third byte of `int a` stored at 0x1000 would be `(char*)&a + 2`
    - can't add a fraction of a byte to only get part of the way into a variable
  - since we casted it to a char pointer it returns *one* byte from the int
  - if we tried `*((char*)&a + 2)` the machine wouldn't know where the boundary of the variable is
  - `*((int*)((char*)&a + 2))` just grabs the 4 bytes after whatever the third byte of `a`

## endianness
- endianness has to do with how multi-byte variables are stored
- little endian: first (lowest) byte is at the lowest memory address
- big endian: first (lowest) byte is at the highest memory address
- this DOES NOT EFFECT ARRAYS