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

# 9/11
