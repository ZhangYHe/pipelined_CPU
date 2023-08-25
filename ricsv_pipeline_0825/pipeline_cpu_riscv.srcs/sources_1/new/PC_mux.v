`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:11:39
// Design Name: 
// Module Name: PC_mux
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


module PC_mux(
    input [31:0] PCin,
    input [31:0] imm,
    input [31:0] IF_PC,
    input br,
    output [31:0] PC_imm,
    output [31:0] PC4,
    output reg [31:0] PCout
);

assign PC_imm = PCin + imm;
assign PC4 = IF_PC + 4;

always@(*) begin
    if(br) PCout = PCin + imm;//发生分支后计算的新PC
    else PCout = IF_PC + 4; //正常向下读
end
endmodule
