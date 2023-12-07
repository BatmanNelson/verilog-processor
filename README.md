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
