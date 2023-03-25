`timescale 1ns / 1ps

module FIFO_8to16_tb();
    reg clk,reset,we,re;
    reg [7:0] data_in;
    wire full,empty;
    wire [7:0] data_out;
    
FIFO_8to16 uut (clk,reset,we,re,data_in,data_out,full,empty);
initial begin
    clk = 0;
    reset = 1;
    data_in = 8'd0;
    we=0;
    re=0;
end
always #5 clk = ~clk;

initial begin
    #10 reset =0;
    
    #10 we=1; re=0; data_in=8'd10;
    #10 we=1; re=0; data_in=8'd12;
    #10 we=1; re=0; data_in=8'd15;
    #10 we=1; re=0; data_in=8'd17;
    #10 we=1; re=0; data_in=8'd14;
    #10 we=1; re=0; data_in=8'd13;
    #10 we=0; re=1;
    #10 we=0; re=1;
    #10 we=0; re=1;
    #10 we=0; re=1;
    #10 we=0; re=1;
    #10 we=1; re=1; data_in=8'd9;
    #30 we=1; re=0;
    
    #30 $finish;
end
endmodule
