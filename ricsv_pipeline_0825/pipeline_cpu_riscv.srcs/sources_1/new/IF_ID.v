`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:15:34
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input clk,rst,
    input [31:0] IF_PC,
    input [31:0] IF_PC4,
    input [31:0] IF_ins,
    input halt,flush,
    output reg [31:0] ID_PC, 
    output reg [31:0] ID_PC4, 
    output reg [31:0] ID_ins
);
always@(posedge clk) begin
   if(halt) begin//load-use 停顿指令
       ID_ins <= ID_ins;
       ID_PC <= ID_PC;
       ID_PC4 <= ID_PC4;
   end
   else if(flush) ID_ins <= 0;//分支时清空ID
   else begin
       ID_PC <= IF_PC;
       ID_PC4 <= IF_PC4;
       ID_ins <= IF_ins;
   end
end
endmodule
