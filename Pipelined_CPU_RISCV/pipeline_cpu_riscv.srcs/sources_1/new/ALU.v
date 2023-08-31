`timescale 1ns / 1ps
`include "HeadFile.vh"


module ALU(
    input [`ALU_OP_LENGTH  - 1:0] aluOp,
    input [31:0] src1,
    input [31:0] src2,
    output zero,
    output less,
    output reg OF,
    output reg [31:0] aluRes
);

assign zero = (aluRes == 0)? 1:0;
assign less = aluRes[31];
reg CF;

always@(*) begin
    CF = 0;
    case(aluOp)
       `ALU_OP_ADD:
            {CF, aluRes} = src1 + src2;
       `ALU_OP_SUB:
            {CF, aluRes} = src1 - src2;
       `ALU_OP_SLT: 
            aluRes = (src1 < src2) ? 32'h00000001 : 32'h00000000;
       `ALU_OP_AND: 
            aluRes = src1 & src2;
        `ALU_OP_OR:
            aluRes = src1 | src2;
        `ALU_OP_XOR:
            aluRes = src1 ^ src2;
        `ALU_OP_SLL:
            aluRes = src1 << src2;
        `ALU_OP_SRL:
            aluRes = src1 >> src2;
    endcase
    
    OF = src1[31] ^ src2[31] ^ CF;
end
endmodule
