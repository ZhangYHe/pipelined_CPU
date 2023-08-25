`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:12:49
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input rst,
    input br,
    input halt,//停顿信号
    input [31:0] PCin,
    output reg [31:0] PCout
);
initial begin
    PCout <= 32'h3000;
end

always@(posedge clk) begin
    if(rst) PCout <= 32'h3000;
    else if(halt) PCout <= PCout;
    else PCout <= PCin;
end

endmodule
