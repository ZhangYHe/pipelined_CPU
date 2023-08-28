`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:48:22
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input clk, rst, we,
    input [7:0] addr,
    input [7:0] io_addr, // 8位外设输入地址
    input [31:0] wd,
    output [31:0] r1,
    output [7:0] io_rd, // 8位外设输出
    output [3:0] data1,
    output [3:0] data2,
    output [3:0] data3,
    output [3:0] data4,
    output [3:0] data5
);

//dist_mem_gen_1 mem(
//  .a(addr),      // input wire [9 : 0] a
//  .d(wd),      // input wire [31 : 0] d
//  .clk(clk),  // input wire clk
//  .we(we),    // input wire we
//  .spo(r1)  // output wire [31 : 0] spo
//);

reg [31:0] dmem [255:0];
initial begin 
    dmem[0] <= 32'd3;
    dmem[1] <= 32'd1;
    dmem[2] <= 32'd2;
    dmem[3] <= 32'd7;
    dmem[4] <= 32'd9; 
end

assign r1 = dmem[addr];
assign io_rd = dmem[io_addr][7:0];
assign data1 = dmem[0][3:0];
assign data2 = dmem[1][3:0];
assign data3 = dmem[2][3:0];
assign data4 = dmem[3][3:0];
assign data5 = dmem[4][3:0];

always @(posedge clk) begin
    if (we) begin
        dmem[addr] <= wd;
    end
end

endmodule