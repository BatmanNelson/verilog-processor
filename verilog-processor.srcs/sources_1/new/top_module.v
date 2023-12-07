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
    output reg [6:0] seg,
    output reg dp);

    wire [6:0] add_6bit_vars;
    wire [6:0] subtract_6bit_vars;
    
    add_6bit      i0 (sw[11:6], sw[5:0], add_6bit_vars[5:0],      add_6bit_vars[6]);
    subtract_6bit i1 (sw[11:6], sw[5:0], subtract_6bit_vars[5:0], subtract_6bit_vars[6]);
    
    always @(posedge clk) begin
        if (button) begin
            led = 16'h0000;
            seg  = 7'b1111111;
            dp   = 1'b1;

            case (sw[15:12])
                0000: begin
                    led[5:0] = add_6bit_vars[5:0];
                    dp       = ~add_6bit_vars[6];
                end

                0001: begin
                    led[5:0] = subtract_6bit_vars[5:0];
                    dp       = ~subtract_6bit_vars[6];
                end

                default: begin
                    seg  = 7'b0111111;
                end
            endcase
        end
    end

endmodule
