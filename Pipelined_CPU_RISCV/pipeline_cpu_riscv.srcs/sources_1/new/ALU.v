`timescale 1ns / 1ps
`include "HeadFile.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:39:15
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [`ALU_OP_LENGTH  - 1:0] aluOp,
    input [31:0] sr1,
    input [31:0] sr2,
    output zero,
    output less,
    output reg [31:0] res
);

assign zero = (res == 0)? 1:0;
assign less = res[31];

always@(*) begin
    case(aluOp)
       `ALU_OP_ADD:
            res = sr1 + sr2;
       `ALU_OP_SUB:
            res = sr1 - sr2;
       `ALU_OP_SLT: 
            res = (sr1 < sr2) ? 32'h00000001 : 32'h00000000;
       `ALU_OP_AND: 
            res = sr1 & sr2;
        `ALU_OP_OR:
            res = sr1 | sr2;
        `ALU_OP_XOR:
            res = sr1 ^ sr2;
        `ALU_OP_SLL:
            res = sr1 << sr2;
        `ALU_OP_SRL:
            res = sr1 >> sr2;
    endcase
end
endmodule
