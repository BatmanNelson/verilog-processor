`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2023 04:55:30 PM
// Design Name: 
// Module Name: divide_6bit
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
module divide_6bit(
    input [5:0] x,
    input [5:0] y,
    output reg [5:0] out,
    output div_by_0);

    // assign out = x / y;

    reg [5:0] x_temp;
    reg [5:0] y_temp;
    wire x_sign = x[5];
    wire y_sign = y[5];
    wire out_sign;
    wire [9:0] temp;

    assign temp = x_temp[4:0] / y_temp[4:0];
    assign out_sign = x[5] ^ y[5];

    always @(*) begin
        if (x_sign) begin
            // if (x == 6'b100000) begin
            //     x_temp = ~x + 1'b1;
            // end
            // else begin
            //     x_temp = x;
            // end

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

    assign div_by_0 = ~(y[5] | y[4] | y[3] | y[2] | y[1] | y[0]);

endmodule
