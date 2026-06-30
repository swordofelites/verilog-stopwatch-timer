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


module stopwatch(
input clk,
input reset,
input startstop,
input [1:0] mode,
input [7:0] preset,
output [15:0] displayval
    );
    localparam clr = 2'b00, wait_ = 2'b01, count = 2'b10;
    reg [1:0] currstate, nextstate; 
    reg tim_clr;
    reg tim_ld;
    reg synch_clr;
    reg synch_ld;
    wire done;
    wire synch_max; 
    reg[15:0] time_reg;
    reg[19:0] synch_reg;
    assign synch_max =  (synch_reg == 20'd1000000) ? 1'b1:1'b0;
    assign done = (mode[0] == 1'b1) ? (time_reg ==16'h0000) : (time_reg == 16'h9999);
    assign displayval = time_reg;
    
    
    always @(posedge clk) begin
        if (reset) begin
            currstate <= clr;
        end
        else begin
            currstate <= nextstate;
        end
    end
    always @(*) begin
        nextstate = currstate;
        case(currstate)
            clr: begin
                if (startstop) begin
                nextstate = wait_;
                end
            end
            wait_: begin
                if (reset) begin
                    nextstate = clr;
                end
                else if(startstop) begin
                    nextstate = count;
                end
            end
            count: begin
                if (reset) begin
                    nextstate = clr;
                 end
                 else if(done || startstop) begin
                    nextstate = wait_;
                 end
                 else begin
                    nextstate = count;
                 end
            end 
        endcase
    end
    always @(*) begin
        tim_clr = 1'b0;
        tim_ld = 1'b0;
        synch_clr = 1'b0;
        synch_ld = 1'b0;
        case(currstate)
            clr: begin
                tim_clr = 1'b1;
                tim_ld = 1'b1;
                synch_clr = 1'b1;
                synch_ld = 1'b0;
                
            end
            wait_: begin
                synch_clr = 0;
                tim_clr = 0;
                synch_ld = 0;
                tim_ld = 0;
            end
            count: begin
                synch_ld = 1;
                tim_ld = 1;
            end
        endcase
   end
   always @(posedge clk) begin
        if((synch_clr == 1'b1) || (synch_max ==1'b1)) begin
            synch_reg <= 0;
        end
        else if (synch_ld ==1'b1) begin
            synch_reg <= synch_reg + 1;
        end
        if (tim_clr ==1'b1) begin
            if (mode[1]) begin
                time_reg <= {preset[7:0], 8'b00000000};
            end
            else if (mode[0]) begin
                time_reg <= 16'h9999;
            end
            else begin
                time_reg <=0;
            end
        end    
        else if (tim_ld ==1'b1&&synch_max ==1'b1) begin
        
            if (mode[0]==1'b1) begin
                if (time_reg[3:0] ==4'h0) begin
                    time_reg[3:0] <=4'h9;
                    if (time_reg[7:4] == 4'h0) begin
                        time_reg[7:4] <=4'h9;
                        if (time_reg[11:8] ==4'h0) begin
                            time_reg[11:8] <=4'h9;
                            if (time_reg [15:12] != 4'h0) begin
                                time_reg[15:12] <=time_reg[15:12] -1;
                            end
                        end 
                        else begin
                            time_reg[11:8] <=time_reg[11:8] -1;
                        end       
                    end   
                    else begin
                        time_reg[7:4] <=time_reg[7:4] -1;
                    end
                end
                else begin
                        time_reg[3:0] <=time_reg[3:0] - 1;
                 end    
            end  
            else begin
                if(time_reg[3:0]==4'h9) begin
                    time_reg[3:0] <= 4'h0;
                    if(time_reg[7:4] ==4'h9) begin
                        time_reg[7:4] <=4'h0;
                        if(time_reg[11:8] == 4'h9) begin
                            time_reg[11:8] <=4'h0;
                            if(time_reg[15:12] != 4'h9) begin
                                time_reg[15:12] <= time_reg[15:12] +1;
                             end
                        end
                        else begin
                            time_reg[11:8] <=time_reg[11:8]+1;
                        end
                    end 
                    else begin
                        time_reg[7:4] <= time_reg[7:4]+1;
                    end
                end
                else begin
                    time_reg[3:0] <= time_reg[3:0] +1;
                end
           end
        end
    end
endmodule
