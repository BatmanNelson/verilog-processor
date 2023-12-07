`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2023 04:04:51 PM
// Design Name: 
// Module Name: multiply_6bit
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


// -32 doesnt work
module multiply_6bit(
    input [5:0] x,
    input [5:0] y,
    output reg [5:0] out,
    output overflow);

    reg [5:0] x_temp;
    reg [5:0] y_temp;
    wire x_sign = x[5];
    wire y_sign = y[5];
    wire out_sign;
    wire [9:0] temp;

    assign temp = x_temp[4:0] * y_temp[4:0];
    assign out_sign = x[5] ^ y[5];

    always @(*) begin
        if (x_sign) begin
            x_temp = ~x + 1'b1;
        end
        else begin
            x_temp = x;
        end

        if (y_sign) begin
            y_temp = ~y + 1'b1;
        end
        else begin
            y_temp = y;
        end

        if (out_sign) begin
            out = ~temp[4:0] + 1'b1;
        end
        else begin
            out = temp[4:0];
        end
    end

    assign overflow = temp[5] | temp[6] | temp[7] | temp[8] | temp[9];

endmodule
