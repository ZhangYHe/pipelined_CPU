`timescale 1ns / 1ps
`include "HeadFile.vh"


module PC(
    input clk,
    input rst,
    input br,
    input halt,
    input [31:0] PC_in,
    output reg [31:0] PC_out
);
initial begin
    PC_out <= `PC_INIT_ADDR; //��ʼ��ַ0x3000
end

always@(posedge clk) begin
    if(rst) 
        PC_out <= `PC_INIT_ADDR; //�ص���ʼPC
    else if(halt) 
        PC_out <= PC_out; //ͣ��
    else 
        PC_out <= PC_in;
end

endmodule
