`timescale 1ns / 1ps


module PC(
    input clk,
    input rst,
    input br,
    input halt,
    input [31:0] PC_in,
    output reg [31:0] PC_out
);
initial begin
    PC_out <= 32'h3000; //初始地址0x3000
end

always@(posedge clk) begin
    if(rst) 
        PC_out <= 32'h3000; //回到初始PC
    else if(halt) 
        PC_out <= PC_out; //停顿
    else 
        PC_out <= PC_in;
end

endmodule
