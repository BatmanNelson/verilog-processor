# Verilog Processor
Digital systems final project, a processor coded in Verilog for Basys 3 FPGA.

Actual code is in ./verilog-processor.srcs/sources_1/new/

## Operations

| Op code       | Operation     | Bits for mem  | Bits for data | Function      | Notes         |
| ------------- |:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|
| 0000          | add_6bit      | n/a           | 11:0          | 11:6 + 5:0    | In 2's comp   |
| 0001          | subtract_6bit | n/a           | 11:0          | 11:6 - 5:0    | "             |

### This is the development branch, push all additions here
