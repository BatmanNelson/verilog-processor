`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 01:54:54 PM
// Design Name: 
// Module Name: add_6bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module add_6bit(
    input [5:0] x,
    input [5:0] y,
    output [5:0] out,
    input overflow);
    
    wire [6:0] temp;
    wire [5:0] carry2;
    
    assign temp     = x + y;
    assign carry2   = x[4:0] + y [4:0];
    assign out      = temp[5:0];
    assign overflow = temp[6] ^ carry2[5];
    
endmodule
