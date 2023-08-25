`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:36:03
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    input clk,rst,
    input [4:0] r1,
    input [4:0] r2,
    // input [4:0] r3,
    input we,//写使能
    input [4:0] writer,
    input [31:0] wd,
    output reg [31:0] rd1,
    output reg [31:0] rd2
    // output reg [31:0] rd3
);

reg [31:0] regF [0:31];
integer i;

initial for(i=0;i<32;i=i+1) regF[i] <=0;

wire eq1,eq2, eq3;//写与读寄存器是否相等的信号量
assign eq1 = (r1 == writer)? 1:0;
assign eq2 = (r2 == writer)? 1:0;
// assign eq3 = (r3 == writer)? 1:0;


always@(*) begin//写优先，如果目的寄存器与源寄存器相同，则直接将写入值输出
    if(eq1 && (writer>0) ) rd1 = wd;
    else rd1 = regF[r1];
    if(eq2 && (writer>0)) rd2 = wd;
    else rd2 = regF[r2];
    // if(eq3 && (writer>0)) rd3 = wd;
    // else rd3 = regF[r3];
end

always@(posedge clk) begin
    if(rst) begin
      for(i = 0; i<32; i= i + 1) begin 
        regF[i] <= 0; 
      end
    end
    else if(we && (writer>0)) regF[writer] <= wd;
end
endmodule
