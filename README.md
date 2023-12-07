# Verilog Processor
Digital systems final project, a processor coded in Verilog for Basys 3 FPGA.

Only source code, Vivado and Basys 3 file need to be generated to run.

## Operations

| Op code       | Operation     | Bits for mem  | Bits for data | Function      | Notes         |
|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|
| 0000          | add_6bit      | -             | 11:0          | 11:6 + 5:0    | In 2's comp   |
| 0001          | subtract_6bit | -             | 11:0          | 11:6 - 5:0    | In 2's comp   |
| 0010          | L_shift       | -             | 11:0          | 10:0 -> 11:1  |               |
| 0011          | R_shift       | -             | 11:0          | 11:1 -> 10:0  |               |
| 0100          | multiply_6bit | -             | 11:0          | 11:6 * 5:0    | In 2's comp   |
| 0101          | divide_6bit   | -             | 11:0          | 11:6 / 5:0    | In 2's comp   |
| 0110          | not           | -             | 11:0          | ~11:0         | Flip bits     |
| 0111          | negate        | -             | 11:0          | ~11:0 + 1'b1  | In 2's comp   |
| 1000          | load          | 11:8          | 7:0           | load data     |               |
| 1001          | store         | 11:8          | 7:0           | store data    |               |

## Examples and additional information
Examples of each operation as well as more detailed limitations of each operation are shown below.

### Overflow
Overflow is displayed on the 7-segment display as the decimal point. If all of the four decimal points are on, an overflow has occured.

### Command formatting
Each command is 16 bits long. The first 4 bits are always the op code of the operation desired. The remaining 12 bits are defined by the operation.

### 0000 add_6bit
This operation adds two 6-bit numbers in 2's complement notation.

| Equation | 1st # in 2's comp | 2nd # in 2's comp | Command              | Desired Result | Actual Result   | Overflow |
|:--------:|:-----------------:|:-----------------:|:--------------------:|:--------------:|:---------------:|:--------:|
| 5 + 9    | 000101            | 001001            | `0000 000101 001001` | `001110`       | `001110`        | No       |
| 31 + 1   | 011111            | 000001            | `0000 011111 000001` | `0100000`      | `100000`        | Yes      |
| -32 + -1 | 100000            | 111111            | `0000 000101 001001` | `1011111`      | `011111`        | Yes      |

Limitations:

If the result of the addition is greater than 31 or less than -32, an overflow occurs.

### 0001 subtract_6bit
This operation subtracts two 6-bit numbers in 2's complement notation.

| Equation | 1st # in 2's comp | 2nd # in 2's comp | Command              | Desired Result | Actual Result | Display | Overflow |
|:--------:|:-----------------:|:-----------------:|:--------------------:|:--------------:|:-------------:|:-------:|:--------:|
| 5 - 9    | 000101            | 001001            | `0001 000101 001001` | `111100`       | `111100`      | -4      | No       |
| -32 - 1  | 100000            | 000001            | `0001 100000 000001` | `1011111`      | `011111`      | 31      | Yes      |
| 28 - -4  | 111000            | 111100            | `0001 111000 111100` | `0100000`      | `100000`      | -32     | Yes      |

Limitations:

If the result of the subtraction is greater than 31 or less than -32, an overflow occurs.

### 0010 L_shift
This operation shifts all of the bits in the 12-bit input one bit to the left.

| Input        | Command             | Result         | Display |
|:------------:|:-------------------:|:--------------:|:-------:|
| 000000000000 | `0010 000000000000` | `000000000000` | 0       |
| 111111111111 | `0010 111111111111` | `111111111110` | ???     |
| 101010101010 | `0010 101010101010` | `010101010100` | ???     |
| 010101010101 | `0010 010101010101` | `101010101010` | ???     |

Limitations:

The right most bit will be set to a 0 and the left most bit of the input will be lost.

### 0011 R_shift
This operation shifts all of the bits in the 12-bit input one bit to the right.

| Input        | Command             | Result         | Display |
|:------------:|:-------------------:|:--------------:|:-------:|
| 000000000000 | `0011 000000000000` | `000000000000` | 0       |
| 111111111111 | `0011 111111111111` | `011111111111` | ???     |
| 101010101010 | `0011 101010101010` | `010101010101` | ???     |
| 010101010101 | `0011 010101010101` | `001010101010` | ???     |

Limitations:

The left most bit will be set to a 0 and the right most bit of the input will be lost.

### 0100 multiply_6bit
This operation multiplies two 6-bit integers in 2's complement notation.

| Equation | 1st # in 2's comp | 2nd # in 2's comp | Command              | Desired Result | Actual Result | Display | Overflow |
|:--------:|:-----------------:|:-----------------:|:--------------------:|:--------------:|:-------------:|:-------:|:--------:|
| 5 * 9    | 000101            | 001001            | `0100 000101 001001` | `111100`       | `111100`      | -4      | No       |
| -32 * 1  | 100000            | 000001            | `0100 100000 000001` | `100000`       | `000000`      | 0       | Yes      |
| -16 * 2  | 110000            | 000010            | `0100 110000 000010` | `100000`       | `100000`      | -32     | No       |
| 16 * 2   | 010000            | 000010            | `0100 010000 000010` | `0100000`      | `000000`      | 0       | Yes      |

Limitations:

The value -32 must not be used as an input due to the value being negated for multiplication which results in an overflow.

If the result of the multiplication is greater than 31 or less than -32, an overflow occurs.

### 0101 divide_6bit
This operation multiplies two 6-bit integers in 2's complement notation.

| Equation | 1st # in 2's comp | 2nd # in 2's comp | Command              | Desired Result | Actual Result | Display | Overflow |
|:--------:|:-----------------:|:-----------------:|:--------------------:|:--------------:|:-------------:|:-------:|:--------:|
| 5 / 9    | 000101            | 001001            | `0101 000101 001001` | `000000`       | `000000`      | 0       | No       |
| -32 / 1  | 100000            | 000001            | `0101 100000 000001` | `110000`       | `000000`      | 0       | Yes      |
| -16 / 2  | 110000            | 000010            | `0101 110000 000010` | `111000`       | `111000`      | -8      | No       |
| 16 / 2   | 010000            | 000010            | `0101 010000 000010` | `001000`       | `001000`      | 8       | No       |
| 1 / 0    | 000001            | 000000            | `0101 000001 000000` | Undefined      | `011111`      | 31      | Yes      |
| -32 / 0  | 100000            | 000000            | `0101 100000 000000` | Undefined      | `100001`      | -1      | Yes      |
| 15 / 4   | 001111            | 000100            | `0101 001111 000100` | `000011`       | `000011`      | 3       | No       |

Limitations:

Any digits past the decimal point will be truncated. Rounding does not occur.

The value -32 must not be used as an input due to the value being negated for division which results in an overflow.

If the result of the division is greater than 31 or less than -31, an overflow occurs.

Dividing by 0 will result in an overflow.

### 0110 not
This operation flips all of the bits of the input.

| Input        | Command             | Result         | Display |
|:------------:|:-------------------:|:--------------:|:-------:|
| 000000000000 | `0011 000000000000` | `111111111111` | 0       |
| 111111111111 | `0011 111111111111` | `000000000000` | ???     |
| 101010101010 | `0011 101010101010` | `010101010101` | ???     |
| 010101010101 | `0011 010101010101` | `101010101010` | ???     |

### 0111 negate
This operation flips all the bits and adds one to get the negative of the input in 2's complement.

| Input        | Command             | Result         | Display |
|:------------:|:-------------------:|:--------------:|:-------:|
| 000000000000 | `0011 000000000000` | `000000000000` | 0       |
| 111111111111 | `0011 111111111111` | `000000000001` | ???     |
| 101010101010 | `0011 101010101010` | `010101010110` | ???     |
| 010101010101 | `0011 010101010101` | `101010101011` | ???     |

Limitations:

Note that negating 0 is still 0 since there is no negative 0 in 2's complement.
