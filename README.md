# Verilog Processor
Digital systems final project, a processor coded in Verilog for Basys 3 FPGA.

Actual code is in ./verilog-processor.srcs/sources_1/new/

## Operations

| Op code       | Operation     | Bits for mem  | Bits for data | Function      | Notes         |
| ------------- |:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|
| 0000          | add_6bit      | -             | 11:0          | 11:6 + 5:0    | In 2's comp   |
| 0001          | subtract_6bit | -             | 11:0          | 11:6 - 5:0    | In 2's comp   |
| 0010          | L_shift       | -             | 11:0          | 10:0 > 11:1   |               |
| 0011          | R_shift       | -             | 11:0          | 11:1 > 10:0   |               |
| 0100          | multiply_6bit | -             | 11:0          | 11:6 * 5:0    | In 2's comp   |
| 0101          | divide_6bit   | -             | 11:0          | 11:6 / 5:0    | In 2's comp   |
| 0110          | load          | 11:8          | 7:0           | load data     |               |
| 0111          | store         | 11:8          | 7:0           | store data    |               |

### This is the development branch, push all additions here
