`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 16:00:48
// Design Name: 
// Module Name: Hazard_Unit
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


module Hazard_Unit(
    input jump,
    input ID_EX_memrd,
    input [4:0] rs1,rs2,dr,
    output reg halt,//load-use的停顿信号
    output reg flush//跳转的清空信号
);

initial begin
    halt <= 0; flush <= 0;
end

always@(*) begin
    halt = 0; flush = 0;
    if((ID_EX_memrd &&
    ((dr == rs1) || (dr == rs2))))begin//load use
       halt = 1;
    end
    if(jump) flush = 1;//branch
end
endmodule
