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
    input [7:0] addr, //7改为9
    input [31:0] wd,
    output [31:0] r1
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

always @(posedge clk) begin
    if (we) begin
        dmem[addr] <= wd;
    end
end

endmodule