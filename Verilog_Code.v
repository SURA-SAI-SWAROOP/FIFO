`timescale 1ns / 1ps

module FIFO_8to16(
    input clk,reset,we,re,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output full,empty
    );
    
    reg [3:0] wr_ptr,rd_ptr;
    reg [3:0] count;
    integer i;
    
    reg [7:0] mem [15:0];

// counter
always @(posedge clk)
begin
    if(reset)
        count <= 5'b0;
    else if(we && ~full)
        count <= count + 1;
    else if(re && ~empty)
        count <= count - 1;
end

assign full = (count == 4'd15)?1:0;
assign empty = (count == 4'd0)?1:0;

//writing operation
always @(posedge clk)
begin
    if(reset)
    begin
        for(i=0;i<16;i=i+1)
        begin
            mem[i] <= 0;
            wr_ptr <= 0;
        end
    end
    
    else if(we && ~full)
    begin
        mem[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr + 1;
    end
    
    else
        wr_ptr <= wr_ptr;
end

//reading operation
always@(posedge clk)
begin
    if(reset)
    begin
        rd_ptr <= 0;
        data_out <= 0;
    end
    
    else if(re && ~empty)
    begin
        data_out <= mem[rd_ptr];
        rd_ptr <= rd_ptr + 1;
    end
    
    else
    begin
        data_out <= 0;
        rd_ptr<= rd_ptr;
    end
end
     
endmodule
