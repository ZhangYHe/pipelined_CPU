`timescale 1ns / 1ps


module REG_ID_EX(
    input clk,rst,
    input halt,
    input is_jal,
    input is_beq,
    input is_bge,
    input [1:0] regS,
    input [3:0] ALUop,
    input memWe,
    input ALUsrc,
    input regWe,
    input [31:0] ID_rd1,
    input [31:0] ID_rd2,
    input [31:0] ID_PC,
    input [31:0] ID_PC4,
    input [31:0] imm,
    input [4:0] rs1, rs2, dr,

    output reg EX_JAL,
    output reg EX_BEQ,
    output reg EX_BGE,
    output reg [1:0] EX_regS,
    output reg [3:0] EX_ALUop,
    output reg EX_memWe,
    output reg EX_ALUsrc,
    output reg EX_regWe,
    output reg [31:0] EX_PC,
    output reg [31:0] EX_rd1,
    output reg [31:0] EX_rd2,
    output reg [31:0] EX_imm,
    output reg [4:0] EX_rs1, EX_rs2, 
    output reg [4:0] EX_dr,
    output reg [31:0] EX_PC4
);

always@(posedge clk) begin
    EX_JAL <= is_jal;
    EX_BEQ <= is_beq;
    EX_BGE <= is_bge;
    EX_regS <= regS;
    EX_ALUop <= ALUop;
    EX_memWe <= memWe;
    EX_ALUsrc <= ALUsrc;
    EX_regWe <= regWe;
    EX_rd1 <= ID_rd1;
    EX_rd2 <= ID_rd2;
    EX_imm <= imm;
    EX_PC <= ID_PC;
    EX_rs1 <= rs1;
    EX_rs2 <= rs2;
    EX_dr <= dr;
    EX_PC4 <= ID_PC4;
end
endmodule