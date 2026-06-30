`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 10:01:23 PM
// Design Name: 
// Module Name: tb_top
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


module tb_top();
    reg clk;
    reg reset;
    reg startstop;
    reg [1:0] mode;
    reg [7:0] preset;

    wire [6:0] seg;
    wire [3:0] an;
    wire dp;

    top uut (
        .clk(clk), 
        .reset(reset), 
        .startstop(startstop), 
        .mode(mode), 
        .preset(preset), 
        .seg(seg), 
        .an(an), 
        .dp(dp)
    );

    always #5 clk = ~clk;

    task press_button;
        input integer button_choice; 
        begin
            if (button_choice == 0) reset = 1;
            else startstop = 1;
            
            #10500000;
            
            if (button_choice == 0) reset = 0;
            else startstop = 0;
            
            #10500000;
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
        press_button(0); 
        #1000;
        press_button(1);
        #10500000;
        press_button(1);
        #1000;

        $display("Mode 0 (count up from 0)");
        mode = 2'b00;
        press_button(0);
        #1000;
        press_button(1);
        #20500000;
        press_button(1);
        #1000;

        $display("Mode 1 (count down from 99.99)");
        mode = 2'b01;
        press_button(0);
        #1000;
        press_button(1);
        #20500000;
        press_button(1);
        #1000;

        $display("Mode 3 (count down) w/ preset @ 72.00");
        mode = 2'b11;
        preset = 8'h72;
        press_button(0);
        #1000;
        press_button(1);
        #20500000;
        press_button(1);
        #1000;

        $display("Finished tb_top");
        $finish;
    end
endmodule