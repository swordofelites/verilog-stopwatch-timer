`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2026 02:35:45 AM
// Design Name: 
// Module Name: tb_debouncer
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


module tb_debouncer();
    reg clk;
    reg btn_in;
    wire btn_out;

    debouncer uut (
        .clk(clk),
        .btn_in(btn_in),
        .btn_out(btn_out)
    );

    always #5 clk = ~clk;
    initial begin
        clk = 0;
        btn_in = 0;
        #100;

        $display("Pres");
        btn_in = 1; #20;
        btn_in = 0; #30;
        btn_in = 1; #10;
        btn_in = 0; #40;

        $display("Hold");
        btn_in = 1;
        #10500000; 

        $display("Release bounce");
        btn_in = 0; #20;
        btn_in = 1; #30;
        btn_in = 0; 
        #10500000;
        
        $display("Debounced");
        $finish;
    end
endmodule