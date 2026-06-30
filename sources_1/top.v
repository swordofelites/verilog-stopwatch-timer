`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 09:05:50 PM
// Design Name: 
// Module Name: top
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


module top(
input clk,
input reset,
input startstop,
input [1:0] mode,
input [7:0] preset,
output [6:0] seg,
output [3:0] an,
output dp
    );
    wire [15:0] displayval;
    wire refresh_clk;
    reg active_dp;
    assign dp = active_dp;
    reg [1:0] digit_select;
    reg [3:0] hex_to_decode;
    reg [3:0] active_anode;
    wire debounce_startstop;
    wire [15:0] displayval;
    wire debounce_reset;
    debouncer db_startstop (
        .clk(clk),
        .btn_in(startstop),
        .btn_out(debounce_startstop)
        );
    debouncer db_reset (
        .clk(clk),
        .btn_in(reset),
        .btn_out(debounce_reset)
        );
    stopwatch core_logic (
        .clk(clk),
        .reset(debounce_reset),
        .startstop(debounce_startstop),
        .mode(mode),
        .preset(preset),
        .displayval(displayval)
        );
    
    clkdiv display_clock(
        .clk(clk),
        .reset(reset),
         .clk_out(refresh_clk)
         );
     
    hexto7segment decoder(
        .x(hex_to_decode),
        .r(seg)     
        );
    always@(posedge refresh_clk or posedge reset) begin
        if(reset) begin
            digit_select <=2'b00;
        end
        else begin
            digit_select <= digit_select+1;
        end
    end
    always@(*) begin
        case(digit_select)
            2'b00:begin
                hex_to_decode = displayval[3:0];
                active_anode = 4'b1110;
                active_dp = 1'b1;
            end
            2'b01: begin
                hex_to_decode = displayval[7:4];
                active_anode = 4'b1101;
                active_dp = 1'b1;
            end
            2'b10: begin
                hex_to_decode = displayval[11:8];
                active_anode = 4'b1011;
                active_dp = 1'b0;
            end
            2'b11: begin
                hex_to_decode = displayval[15:12];
                active_anode = 4'b0111;
                active_dp = 1'b1;
            end
        endcase
    end
    assign an = active_anode;
endmodule
