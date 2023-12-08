`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 01:22:20 PM
// Design Name: 
// Module Name: hex_to_dec
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


// Unsigned hex to signed decimal
module hex_to_dec(
    input clk,
    input [15:0] d,
    input [3:0] neg_bit,
    output [3:0] an,
    output [6:0] seg,
    input error);

    reg [15:0] hex_num;
    wire [15:0] dec_num;
    reg negative;

    always @(*) begin

        if (neg_bit >= 4'b1100) begin
            negative = 0;
            hex_num = d;
        end

        else if (neg_bit == 5) begin
            if (d[5] == 1) begin
                hex_num[5:0] = ~d[5:0] + 1'b1;
                hex_num[15:6] = 0;
                negative = 1;
            end
            else begin
                hex_num[5:0] = d[5:0];
                hex_num[15:6] = 0;
                negative = 0;
            end
        end

        else if (neg_bit == 11) begin
            if (d[11] == 1) begin
                hex_num[11:0] = ~d[11:0] + 1'b1;
                hex_num[15:12] = 0;
                negative = 1;
            end
            else begin
                hex_num[11:0] = d[11:0];
                hex_num[15:12] = 0;
                negative = 0;
            end
        end
    end

    hex3char_to_dec4char hex_dec (hex_num, dec_num, error);

    seven_seg sevSeg (clk, dec_num, negative, an, seg);
    // seven_seg sevSeg (clk, hex_num, negative, an, seg);
    // seven_seg sevSeg (clk, d, d[5], an, seg);

endmodule
