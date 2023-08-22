`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/21 19:51:47
// Design Name: 
// Module Name: top
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

`include "head_file.vh"

module top(
    input wire clk,
    input wire rst

    );

    // IF
    wire[31:0] pc;
    wire[31:0] inst;

    // Control signals
    wire MemWr;

    //MEM
    wire[9:0] mem_addr;
    wire[31:0] write_mem_data;
    wire[31:0] read_mem_data;

    inst_men instruction_memory (
      .a(pc[11:2]),      // input wire [9 : 0] a    //??可能有问题
      .spo(inst)  // output wire [31 : 0] spo
    );

    data_mem your_instance_name (
      .a(mem_addr),      // input wire [9 : 0] a
      .d(write_mem_data),      // input wire [31 : 0] d
      .clk(clk),  // input wire clk
      .we(MemWr),    // input wire we
      .spo(read_mem_data)  // output wire [31 : 0] spo
    );


endmodule


