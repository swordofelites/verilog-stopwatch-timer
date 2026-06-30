`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 10:57:33 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk,
    input btn_in,
    output btn_out
    );
    reg[19:0] counter = 0;
    reg stable_state = 0;
    reg sync0, sync1;
    always @(posedge clk) begin 
        sync0 <= btn_in;
        sync1 <= sync0;
    end
    always @(posedge clk) begin
        if(sync1 !== stable_state) begin
            counter <= counter + 1; 
            if(counter == 20'd1_000_000) begin
                stable_state <= sync1;
                counter <= 0;
            end
        end
        else begin
            counter <= 0;
        end
    end 
    reg stable_d;
    always @(posedge clk) begin
        stable_d <= stable_state;
    end
    assign btn_out= stable_state&~stable_d;
endmodule
