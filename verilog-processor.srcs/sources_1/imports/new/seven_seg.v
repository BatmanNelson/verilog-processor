`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2023 01:13:47 PM
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


// Modified from Lab 1000
module seven_seg(
    input clk,
    input [15:0] d,
    input negative,
    // input dp_in,
    // output dp_out,
    output reg [3:0] an,
    output reg [6:0] seg);
    
    reg [19:0] counter = 0;
    reg [3:0]  dig;
    reg empty_zero;
    reg show_neg;
    
    // Clock divider
    always @ (posedge clk) begin
        counter = counter + 1;
    end
    
    // Choose which "an" to assert
    always @ (*) begin
        case (counter[19:18])
            2'b00: begin
                an = 4'b1110;
                dig = d[3:0];
                empty_zero = 0;
            end

            2'b01: begin
                an = 4'b1101;
                dig = d[7:4];

                if (d[15:12] == 4'b0000 &&
                    d[11:8]  == 4'b0000 &&
                    dig      == 4'b0000) begin

                    empty_zero = 1;

                    if (negative) begin
                        show_neg = 1;
                    end
                    else begin
                        show_neg = 0;
                    end
                end
                else begin
                    empty_zero = 0;
                    show_neg   = 0;
                end
            end

            2'b10: begin
                an = 4'b1011;
                dig = d[11:8];

                if (d[15:12] == 4'b0000 &&
                    dig      == 4'b0000) begin

                    empty_zero = 1;

                    if (d[7:4] != 4'b0000 &&
                        negative) begin

                        show_neg = 1;
                    end
                    else begin
                        show_neg = 0;
                    end
                end
                else begin
                    empty_zero = 0;
                    show_neg   = 0;
                end
            end

            2'b11: begin
                an = 4'b0111;
                dig = d[15:12];

                if (dig == 4'b0000) begin

                    empty_zero = 1;

                    if (d[11:8] != 4'b0000 &&
                        d[7:4]  != 4'b0000 &&
                        negative) begin

                        show_neg = 1;
                    end
                    else begin
                        show_neg = 0;
                    end
                end
                else begin
                    empty_zero = 0;
                    show_neg   = 0;
                end
            end
        endcase
    end
    
    // Choose values for seg
    always @ (*) begin
        case (dig)
            4'b0000: begin
                if (empty_zero & show_neg)
                    seg = 7'b0111111;  // -
                else if (empty_zero)
                    seg = 7'b1111111;  //' '
                else
                    seg = 7'b1000000;  // 0
            end

            4'b0001: seg = 7'b1111001; // 1
            4'b0010: seg = 7'b0100100; // 2
            4'b0011: seg = 7'b0110000; // 3
            4'b0100: seg = 7'b0011001; // 4
            4'b0101: seg = 7'b0010010; // 5
            4'b0110: seg = 7'b0000010; // 6
            4'b0111: seg = 7'b1111000; // 7
            4'b1000: seg = 7'b0000000; // 8
            4'b1001: seg = 7'b0010000; // 9
            4'b1010: seg = 7'b0001000; // A
            4'b1011: seg = 7'b0000011; // B
            4'b1100: seg = 7'b1000110; // C
            4'b1101: seg = 7'b0100001; // D
            4'b1110: seg = 7'b0000110; // E
            4'b1111: seg = 7'b0001110; // F
            
            // Default turn off
            default: seg = 7'b1111111; //' '
        endcase
    end
    
    // assign dp_out = dp_in;
    
endmodule
