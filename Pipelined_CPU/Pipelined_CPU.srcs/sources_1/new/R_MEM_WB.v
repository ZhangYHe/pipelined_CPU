`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/23 20:23:56
// Design Name: 
// Module Name: R_MEM_WB
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

module R_MEM_WB(
           input wire                        clk,
           input wire                        rst,
           input wire[31:0]                  result_in,
           input wire[31:0]                  read_mem_data_in,
           input wire[31:0]                  pc_jmp_dst_in,
           input wire[31:0]                  ext_imm_in,
           input wire[4:0]                   dstReg_in,
           input wire[`REG_SRC_LENGTH - 1:0] MemtoReg_in,
           input wire                        RegWr_in,
           input wire                        LW_MEM_WB_in,

           output reg[31:0]                  result_out,
           output reg[31:0]                  read_mem_data_out,
           output reg[31:0]                  pc_jmp_dst_out,
           output reg[31:0]                  ext_imm_out,
           output reg[4:0]                   dstReg_out,
           output reg[`REG_SRC_LENGTH - 1:0] MemtoReg_out,
           output reg                        RegWr_out,
           output reg                        LW_MEM_WB_out
       );


wire zeroize;
assign zeroize = rst;

always @ (posedge clk) begin
    // 寄存器清0
    if (zeroize) begin
        result_out      <= `INIT_32;
        read_mem_data_out   <= `INIT_32;
        pc_jmp_dst_out         <= `INIT_32;
        ext_imm_out    <= `INIT_32;
        dstReg_out <= `INIT_32;
        MemtoReg_out      <= `REG_SRC_DEFAULT;
        RegWr_out    <= `REG_WRITE_DISABLE;
        LW_MEM_WB_out    <= `LW_ENABLE;
    end
    // 默认情况输入和输出保持一致
    else begin
        result_out      <= result_in;
        read_mem_data_out   <= read_mem_data_in;
        pc_jmp_dst_out         <= pc_jmp_dst_in;
        ext_imm_out    <= ext_imm_in;
        dstReg_out <= dstReg_in;
        MemtoReg_out      <= MemtoReg_in;
        RegWr_out    <= RegWr_in;
        LW_MEM_WB_out    <= LW_MEM_WB_in;
    end
end
endmodule
