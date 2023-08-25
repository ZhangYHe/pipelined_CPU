`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 16:02:31
// Design Name: 
// Module Name: CPU
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


module  CPU (
  input clk, 
  input rst,
            
  input [31:0] io_din

);

//PC
wire [31:0] PC, ia, PCout, inst;
wire halt;


//ConUn
wire jal;
wire branch;
wire is_bge;
//wire brlt;
wire [31:0] imm_gen;
wire [1:0] regS;
wire [3:0] ALUop;
wire MemWr;
wire ALUsrc;
wire RegW;
//wire PCx1;

//insmem
wire [31:0] insinst_data;   //这个没用
wire ins_w;
assign ins_w = 0;


//Regfile
wire [31:0] rd1, rd2, rd3, wd;    //wd没用

//immgen
wire[31:0] imm_num;

//alu mux
wire[31:0] data_2;

//alu
wire zero;
wire less;
wire [31:0] res;

//data mem
wire dm_we;

wire [31:0] m_rd1, m_rd2;   // m_rd2 没用
wire[31:0] dm_out;

//RF mux
wire [31:0] rf_wd;

//PC mux
wire br;
wire [31:0] pcimm, PC4;

//ID
wire [31:0] ID_PC,ID_PC4;
wire [31:0] ID_ins;

//EX
wire EX_jal;
wire EX_branch;
wire EX_BGE;
wire [1:0] EX_regS;
wire [3:0] EX_ALUop;
wire EX_MemWr;
wire EX_ALUsrc;
wire EX_RegW;
wire [31:0] EX_PC;
wire [31:0] EX_rd1, EX_rd2;
wire [31:0] EX_imm;
wire [4:0] EX_rs1, EX_rs2, EX_dr;
wire [31:0] EX_PC4;

assign br = (zero && EX_branch) | EX_jal | (!less && EX_BGE);

//ME
wire ME_RegW;
wire [1:0] ME_regS;
wire ME_MemWr;
wire [31:0] ME_PC4;
wire [31:0] ME_res;
wire [4:0] ME_dr;
wire [31:0] ME_rfd;

//WB
wire WB_RegW;
wire [1:0] WB_regS;
wire [31:0] WB_PC4;
wire [31:0] WB_dm_rd1;
wire [31:0] WB_res;
wire [4:0] WB_dr;
wire [31:0] WB_rfd;   //没用

//hazard unit
wire EX_memrd;
assign EX_memrd = (EX_regS == 1)? 1:0;

//forward unit
wire [1:0] rs1_f, rs2_f;

//sr mux
wire [31:0] alu_d1, alu_d2;
wire flush;

assign dm_we = (~ME_res[10]) & ME_MemWr;


PC pc1(clk, rst, br, halt, PC, PCout);
InsMem insm(clk, ins_w, ins_data, PCout[11:2], flush, inst);   //PCout[9:2]改为PCout[11:2]
ControlUnit con(ID_ins[6:0], ID_ins[31:25], ID_ins[14:12], halt, flush, jal, branch, is_bge, regS, ALUop, MemWr, ALUsrc, RegW);
RegFile rf(clk, rst, ID_ins[19:15], ID_ins[24:20], WB_RegW, WB_dr, rf_wd, rd1, rd2);
Imm_gen img(ID_ins, imm_num);
ALU_mux am(data_2, EX_imm, EX_ALUsrc, alu_d2);
sr1_mux s1m(rs1_f, EX_rd1, ME_res, rf_wd, alu_d1);
sr2_mux s2m(rs2_f, EX_rd2, ME_res, rf_wd, data_2); 


ALU alu(EX_ALUop, alu_d1, alu_d2, zero, less, res);
DataMem dm(clk, rst, dm_we, ME_res[9:2], ME_rfd, m_rd1);    //ME_res[9:2]改为ME_res[9:0]
//DataMem_mux dm_mux(WB_res[10], WB_dm_rd1, io_din, dm_out);
RF_mux rf_m(WB_regS, WB_PC4, WB_dm_rd1, WB_res, rf_wd);
PC_mux pcm(EX_PC, EX_imm, PCout, br, pcimm, PC4, PC);
IF_ID ifid(clk, rst, PCout, PC4, inst, halt, flush, ID_PC, ID_PC4, ID_ins);
ID_EX idex(clk, rst, halt, jal, branch, is_bge, regS, ALUop, MemWr, ALUsrc, RegW, 
           rd1, rd2, ID_PC, ID_PC4, imm_num, ID_ins[19:15], ID_ins[24:20], ID_ins[11:7],
           EX_jal, EX_branch, EX_BGE, EX_regS, EX_ALUop, EX_MemWr, EX_ALUsrc, EX_RegW,
           EX_PC, EX_rd1, EX_rd2, EX_imm, EX_rs1, EX_rs2, EX_dr, EX_PC4);
EX_ME exme(clk, EX_RegW, EX_regS, EX_MemWr, EX_PC4, res, EX_dr, data_2, 
           ME_RegW, ME_regS, ME_MemWr, ME_PC4, ME_res, ME_dr, ME_rfd);
ME_WB mewb(clk, ME_RegW, ME_regS, ME_PC4, m_rd1, ME_res, ME_dr, ME_rfd,
           WB_RegW, WB_regS, WB_PC4, WB_dm_rd1, WB_res, WB_dr, WB_rfd);
Hazard_Unit hu(br, EX_memrd, ID_ins[19:15], ID_ins[24:20], EX_dr, halt, flush);
Forward_Unit fu(ME_regS, ME_dr, WB_dr, ME_RegW, WB_RegW, EX_rs1, EX_rs2, rs1_f, rs2_f);


//下面是各种输出和外设，可忽略

assign io_addr = ME_res[7:0];
assign io_dout = ME_rfd;
assign io_we = ME_res[10] & ME_MemWr;

assign rf_data = rd3;   //无用
// assign m_data = m_rd2;

//pc if id
assign pc = PCout;
assign pcd = ID_PC;
assign ir = ID_ins;
assign pcin = PC;

//id ex
assign pce = EX_PC;
assign a = EX_rd1;
assign b = EX_rd2;
assign imm = EX_imm;
assign rd = EX_dr;
assign ctrl = {halt, halt, halt, 1'b0, 4'b0, 5'b0, RegW, regS, 2'b0, regS[0], MemWr, 2'b0, jal, branch, 2'b0, 4'b0, ALUop[3:0]};

//ex mem
assign y = ME_res;
assign bm = ME_rfd;
assign rdm = ME_dr;
assign ctrlm = {4'b0, 2'b0, rs1_f, 2'b0, rs2_f, 
                1'b0, ME_RegW, ME_regS, 2'b0, ME_regS[0], ME_MemWr, 2'b0, EX_jal, EX_branch,4'b0, ALUop[3:0]};

//me WB
assign yw = WB_res;
assign mdr = WB_dm_rd1;
assign rdw = WB_dr;
assign ctrlw = {4'b0, 4'b0, 4'b0,
                1'b0, WB_RegW, WB_regS, 2'b0, WB_regS[0], 3'b0, jal, branch,4'b0, ALUop[3:0]};

endmodule