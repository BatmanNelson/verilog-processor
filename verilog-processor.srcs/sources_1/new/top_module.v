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
    wire dp_wire;

    wire [6:0] add_6bit_vars;
    wire [6:0] subtract_6bit_vars;
    wire [6:0] multiply_6bit_vars;
    wire [6:0] divide_6bit_vars;

    add_6bit      i0 (sw[11:6], sw[5:0], add_6bit_vars[5:0],      add_6bit_vars[6]);
    subtract_6bit i1 (sw[11:6], sw[5:0], subtract_6bit_vars[5:0], subtract_6bit_vars[6]);
    multiply_6bit i2 (sw[11:6], sw[5:0], multiply_6bit_vars[5:0], multiply_6bit_vars[6]);
    divide_6bit   i3 (sw[11:6], sw[5:0], divide_6bit_vars[5:0],   divide_6bit_vars[6]);

    seven_seg sevSeg (clk, led, 0, an, seg, dp_wire);

    always @(posedge clk) begin
        if (button) begin
            led = 16'h0000;
            // seg  = 7'b1111111;
            dp   = 1'b1;

            case (sw[15:12])
                4'b0000: begin
                    led[5:0] = add_6bit_vars[5:0];
                    dp       = ~add_6bit_vars[6];
                end

                4'b0001: begin
                    led[5:0] = subtract_6bit_vars[5:0];
                    dp       = ~subtract_6bit_vars[6];
                end

                4'b0010: begin
                    led[11:1] = sw[10:0];
                    // dp       = ~subtract_6bit_vars[6];
                end

                4'b0011: begin
                    led[10:0] = sw[11:1];
                    // dp       = ~subtract_6bit_vars[6];
                end

                4'b0100: begin
                    led[5:0] = multiply_6bit_vars[5:0];
                    dp       = ~multiply_6bit_vars[6];
                end

                4'b0101: begin
                    led[5:0] = divide_6bit_vars[5:0];
                    dp       = ~divide_6bit_vars[6];
                end

                4'b0110: begin
                    led[11:0] = ~sw[11:0];
                end

                4'b0111: begin
                    led[11:0] = ~sw[11:0] + 1'b1;;
                end

                default: begin
                    // seg  = 7'b0111111;
                    led = 16'hffff;
                    dp   = 1'b1;
                end
            endcase
        end
    end

endmodule
