`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:15:34
// Design Name: 
// Module Name: InsMem
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


module InsMem(
    input clk,we,
    input [31:0] ins_d,
    input [9:0] addr, //[7:0]改为9
    input flush,//清空信号
    output reg [31:0] data//输出信号
);
wire [31:0] temp;

instruction_mem my_insmem (
  .a(addr),      // input wire [9 : 0] a
  .d(ins_d),      // input wire [31 : 0] d
  .clk(clk),  // input wire clk
  .we(we),    // input wire we
  .spo(temp)  // output wire [31 : 0] spo
);

always@(*) begin
    if(flush) data = 0;
    else data = temp;
end

endmodule
