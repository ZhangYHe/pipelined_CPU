module ID_EX(
    input clk,rst,
    input halt,
    input jal,
    input branch,
    input is_bge,
    input [1:0] regS,
    input [3:0] ALUop,
    input MemWr,
    input ALUsrc,
    input RegW,
    input [31:0] ID_rd1,
    input [31:0] ID_rd2,
    input [31:0] ID_PC,
    input [31:0] ID_PC4,
    input [31:0] imm,
    input [4:0] rs1, rs2, dr,

    output reg EX_jal,
    output reg EX_branch,
    output reg EX_BGE,
    output reg [1:0] EX_regS,
    output reg [3:0] EX_ALUop,
    output reg EX_MemWr,
    output reg EX_ALUsrc,
    output reg EX_RegW,
    output reg [31:0] EX_PC,
    output reg [31:0] EX_rd1,
    output reg [31:0] EX_rd2,
    output reg [31:0] EX_imm,
    output reg [4:0] EX_rs1, EX_rs2, 
    output reg [4:0] EX_dr,
    output reg [31:0] EX_PC4
);

always@(posedge clk) begin
    EX_jal <= jal;
    EX_branch <= branch;
    EX_BGE <= is_bge;
    EX_regS <= regS;
    EX_ALUop <= ALUop;
    EX_MemWr <= MemWr;
    EX_ALUsrc <= ALUsrc;
    EX_RegW <= RegW;
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