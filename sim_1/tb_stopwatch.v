`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 05:57:34 PM
// Design Name: 
// Module Name: stopwatch
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


module tb_stopwatch();
    reg clk;
    reg reset;
    reg startstop;
    reg [1:0] mode;
    reg [7:0] preset;
    wire [15:0] displayval;

    stopwatch UUT (
        .clk(clk),
        .reset(reset),
        .startstop(startstop),
        .mode(mode),
        .preset(preset),
        .displayval(displayval)
    );

    always #5 clk = ~clk;

    task pulse_button;
        input integer button_choice;
        begin
            if (button_choice == 0) reset = 1;
            else startstop = 1;
            #10;
            if (button_choice == 0) reset = 0;
            else startstop = 0;
            #10;
        end
    endtask

    initial begin
        clk = 0;
        reset = 0;
        startstop = 0;
        mode = 2'b00;
        preset = 8'h00;
        #100;
        
        $display("Mode 1 (count up) w/ preset @ 45.00");
        mode = 2'b10;
        preset = 8'h45;
        pulse_button(0);
        pulse_button(1);
        #10500000;
        pulse_button(1);
        #1000;
        
        $display("Mode 0 (count up from 0)");
        mode = 2'b00;
        pulse_button(0);
        pulse_button(1);
        #20500000;
        pulse_button(1);
        #1000;

        $display("Mode 1 (count down from 99.99)");
        mode = 2'b01;
        pulse_button(0);
        pulse_button(1);
        #20500000;
        pulse_button(1);
        #1000;
        
        $display("Mode 3 (count down) w/ preset @ 72.00");
        mode = 2'b11;
        preset = 8'h72;
        pulse_button(0);
        pulse_button(1);
        #20500000;
        pulse_button(1);
        #1000;
        
        $display("Stopwatch sim done");
        $finish;
    end
endmodule