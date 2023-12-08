`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 04:34:01 PM
// Design Name: 
// Module Name: hex3char_to_dec4char
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


module hex3char_to_dec4char(
    input [15:0] hex_num,
    output [15:0] dec_num,
    input error);

    reg [3:0] [3:0] dec_digits;

    always @(*) begin
        if (error) begin
            dec_digits[0] = 4'd4;
            dec_digits[1] = 4'd0;
            dec_digits[2] = 4'd4;
            dec_digits[3] = 4'd0;
        end
        else begin
            dec_digits[0] = hex_num % 10;
            dec_digits[1] = (hex_num / 10) % 10;
            dec_digits[2] = (hex_num / 100) % 10;
            dec_digits[3] = (hex_num / 1000) % 10;
        end
    end

    assign dec_num = dec_digits;

endmodule
