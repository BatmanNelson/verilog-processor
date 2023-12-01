`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 02:55:21 PM
// Design Name: 
// Module Name: subtract_6bit
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


module subtract_6bit(
    input [5:0] x,
    input [5:0] y,
    output [5:0] out,
    output overflow);
    
    wire [5:0] y_not;

    assign y_not = ~y + 1'b1;

    add_6bit sub1 (x, y_not, out, overflow);
    
//    assign out = y_not;
//    assign overflow = 1'b0;

endmodule
