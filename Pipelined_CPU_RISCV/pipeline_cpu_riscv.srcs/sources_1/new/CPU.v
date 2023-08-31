`timescale 1ns / 1ps
`include "HeadFile.vh"


module  CPU (
	input clk, 
	input rst,
	input [7:0] io_addr, // 8位外设输入
	output [3:0] data1,
	output [3:0] data2,
	output [3:0] data3,
	output [3:0] data4,
	output [3:0] data5,
	output [7:0] io_data // 8位外设输出
);

//PC_mux
wire br;
wire [31:0] pcimm, PC4;

//PC
wire [31:0] PC, PCout, inst;
wire halt;

//InsMem
wire ins_w;
assign ins_w = 0;

//RegFile
wire [31:0] rd1, rd2;

//ControlUnit
wire is_jal;
wire is_beq;
wire is_bge;
wire [31:0] immGen;
wire [1:0] regS;
wire [3:0] ALUop;
wire memWe;
wire ALUsrc;
wire regWe;

//ImmGen
wire[31:0] immNum;

//ALU_mux
wire[31:0] alu_mux_data;

//ALU
wire zero;
wire less;
wire [31:0] res;
wire OF;

//Src_mux
wire [31:0] alu_d1, alu_d2;
wire flush;

//DataMem
wire dm_we;
wire [31:0] dm_data;

//RF_mux
wire [31:0] rf_wd;

//ID
wire [31:0] ID_PC,ID_PC4;
wire [31:0] ID_ins;

//EX
wire EX_JAL;
wire EX_BEQ;
wire EX_BGE;
wire [1:0] EX_regS;
wire [3:0] EX_ALUop;
wire EX_memWe;
wire EX_ALUsrc;
wire EX_regWe;
wire [31:0] EX_PC;
wire [31:0] EX_rd1, EX_rd2;
wire [31:0] EX_imm;
wire [4:0] EX_rs1, EX_rs2, EX_dr;
wire [31:0] EX_PC4;

//ME
wire ME_regWe;
wire [1:0] ME_regS;
wire ME_memWe;
wire [31:0] ME_PC4;
wire [31:0] ME_res;
wire [4:0] ME_dr;
wire [31:0] ME_rfd;

//WB
wire WB_regWe;
wire [1:0] WB_regS;
wire [31:0] WB_PC4;
wire [31:0] WB_dm_rd;
wire [31:0] WB_res;
wire [4:0] WB_dr;

//HazardUnit
wire EX_memrd;
assign EX_memrd = (EX_regS == 1)? 1:0;

//ForwardUnit
wire [1:0] rs_f1, rs_f2;

assign dm_we = (~ME_res[10]) & ME_memWe;
assign br = (zero && EX_BEQ) | EX_JAL | (!less && EX_BGE); //跳转

PC pc(clk, rst, br, halt, PC, PCout);
InsMem insmem(clk, ins_w, ins_data, PCout[11:2], flush, inst);
ControlUnit controlunit(ID_ins[6:0], ID_ins[31:25], ID_ins[14:12], halt, flush, is_jal, is_beq, is_bge, regS, ALUop, memWe, ALUsrc, regWe);
RegFile regfile(clk, rst, ID_ins[19:15], ID_ins[24:20], WB_regWe, WB_dr, rf_wd, rd1, rd2);
ImmGen immgen(ID_ins, immNum);
ALU_mux alumux(alu_mux_data, EX_imm, EX_ALUsrc, alu_d2);
Src1_mux src1mux(rs_f1, EX_rd1, ME_res, rf_wd, alu_d1);
Src2_mux src2mux(rs_f2, EX_rd2, ME_res, rf_wd, alu_mux_data); 
ALU alu(EX_ALUop, alu_d1, alu_d2, zero, less, OF, res);
DataMem datamem(clk, rst, dm_we, ME_res[9:2], io_addr, ME_rfd, dm_data, io_data, data1, data2, data3, data4, data5); 
WB_mux wbmux(WB_regS, WB_PC4, WB_dm_rd, WB_res, rf_wd);
PC_mux pcmux(EX_PC, EX_imm, PCout, br, pcimm, PC4, PC);
REG_IF_ID ifid(clk, rst, PCout, PC4, inst, halt, flush, ID_PC, ID_PC4, ID_ins);
REG_ID_EX idex(clk, rst, halt, is_jal, is_beq, is_bge, regS, ALUop, memWe, ALUsrc, regWe, 
           rd1, rd2, ID_PC, ID_PC4, immNum, ID_ins[19:15], ID_ins[24:20], ID_ins[11:7],
           EX_JAL, EX_BEQ, EX_BGE, EX_regS, EX_ALUop, EX_memWe, EX_ALUsrc, EX_regWe,
           EX_PC, EX_rd1, EX_rd2, EX_imm, EX_rs1, EX_rs2, EX_dr, EX_PC4);
REG_EX_ME exme(clk, EX_regWe, EX_regS, EX_memWe, EX_PC4, res, EX_dr, alu_mux_data, 
           ME_regWe, ME_regS, ME_memWe, ME_PC4, ME_res, ME_dr, ME_rfd);
REG_ME_WB mewb(clk, ME_regWe, ME_regS, ME_PC4, dm_data, ME_res, ME_dr, 
           WB_regWe, WB_regS, WB_PC4, WB_dm_rd, WB_res, WB_dr);
HazardUnit hazardunit(br, EX_memrd, ID_ins[19:15], ID_ins[24:20], EX_dr, halt, flush);
ForwardUnit forwardunit(ME_regS, ME_dr, WB_dr, ME_regWe, WB_regWe, EX_rs1, EX_rs2, rs_f1, rs_f2);

endmodule