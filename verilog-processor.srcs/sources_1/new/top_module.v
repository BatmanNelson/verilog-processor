`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 12:38:47 PM
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clk,
    input button,
    input [15:0] sw,
    output reg [15:0] led,
    output [3:0] an,
    output [6:0] seg,
    output reg dp);

    // wire [3:0] an_wire;
    // wire [6:0] seg_wire;
    // wire dp_wire;

    wire [6:0] add_6bit_vars;
    wire [6:0] subtract_6bit_vars;
    wire [6:0] multiply_6bit_vars;
    wire [6:0] divide_6bit_vars;
    reg  [3:0] neg_bit;
    reg        error;

    add_6bit      i0 (sw[11:6], sw[5:0], add_6bit_vars[5:0],      add_6bit_vars[6]);
    subtract_6bit i1 (sw[11:6], sw[5:0], subtract_6bit_vars[5:0], subtract_6bit_vars[6]);
    multiply_6bit i2 (sw[11:6], sw[5:0], multiply_6bit_vars[5:0], multiply_6bit_vars[6]);
    divide_6bit   i3 (sw[11:6], sw[5:0], divide_6bit_vars[5:0],   divide_6bit_vars[6]);

    hex_to_dec h_dec (clk, led, neg_bit, an, seg, error);

    always @(posedge clk) begin
        if (button) begin
            led  = 16'h0000;
            // seg   = 7'b1111111;
            dp    = 1'b1;
            error = 0;

            case (sw[15:12])

                // Add
                4'b0000: begin
                    led[5:0] = add_6bit_vars[5:0];
                    dp       = ~add_6bit_vars[6];
                    neg_bit  = 5;
                end

                // Subtract
                4'b0001: begin
                    led[5:0] = subtract_6bit_vars[5:0];
                    dp       = ~subtract_6bit_vars[6];
                    neg_bit  = 5;
                end

                // L-shift
                4'b0010: begin
                    led[11:1] = sw[10:0];
                    // dp       = ~subtract_6bit_vars[6];
                    neg_bit  = 4'b1111; // 15 (n/a)
                end

                // R-shift
                4'b0011: begin
                    led[10:0] = sw[11:1];
                    // dp       = ~subtract_6bit_vars[6];
                    neg_bit  = 4'b1111; // 15 (n/a)
                end

                // Multiply
                4'b0100: begin
                    led[5:0] = multiply_6bit_vars[5:0];
                    dp       = ~multiply_6bit_vars[6];
                    neg_bit  = 5;
                end

                // Divide
                4'b0101: begin
                    led[5:0] = divide_6bit_vars[5:0];
                    dp       = ~divide_6bit_vars[6];
                    neg_bit  = 5;
                end

                // Not
                4'b0110: begin
                    led[11:0] = ~sw[11:0];
                    neg_bit   = 4'b1111; // 15 (n/a)
                end

                // Negate
                4'b0111: begin
                    led[11:0] = ~sw[11:0] + 1'b1;
                    neg_bit   = 11;
                end

                // Display
                4'b1000: begin
                    led[11:0] = sw[11:0];
                    neg_bit   = 11;
                end

                default: begin
                    // seg  = 7'b0111111;
                    led     = 16'hffff;
                    error   = 1;
                    // led     = 16'd404;
                    dp      = 1'b1;
                    neg_bit = 4'b1111; // 15 (n/a)
                end
            endcase
        end
    end

endmodule
