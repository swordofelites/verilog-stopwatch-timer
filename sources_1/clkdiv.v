`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2026 10:44:53 PM
// Design Name: 
// Module Name: clkdiv
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


module clkdiv(
    input clk,
    input reset,
    output clk_out
);

    reg [18:0] COUNT; 
    
    assign clk_out = COUNT[18]; 
    
    always @(posedge clk) begin
        if (reset)
            COUNT <= 0;
        else
            COUNT <= COUNT + 1;
    end

endmodule