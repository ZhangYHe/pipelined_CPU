`timescale 1ns / 1ps
`include "head_file.vh"

module ALU(
           input  wire[31:0]                   aluInput_1,
           input  wire[31:0]                   aluInput_2,
           input  wire[4:0]                    sa,
           input  wire[`ALU_OP_LENGTH  - 1:0]  aluOp,

           output wire[31:0]                   aluResult,
           output wire                         isOverflow
       );

reg[32:0] tempResult;
assign aluResult = tempResult[31:0];

// 溢出检测
assign isOverflow = (tempResult[32] != tempResult[31]) ? 1'b1 : 1'b0;

always @ (*) begin
    case (aluOp)
        `ALU_OP_ADD:
            tempResult <= {aluInput_1[31], aluInput_1} + {aluInput_2[31], aluInput_2};

        `ALU_OP_SUB:
            tempResult <= {aluInput_1[31], aluInput_1} - {aluInput_2[31], aluInput_2};

        `ALU_OP_SLT:
            tempResult <= (aluInput_1 < aluInput_2) ? 32'h00000001 : 32'h00000000;

        `ALU_OP_AND:
            tempResult <= {aluInput_1[31], aluInput_1} & {aluInput_2[31], aluInput_2};

        `ALU_OP_OR :
            tempResult <= {aluInput_1[31], aluInput_1} | {aluInput_2[31], aluInput_2};

        `ALU_OP_NOR:
            tempResult <= (({aluInput_1[31], aluInput_1} & ~{aluInput_2[31], aluInput_2}) |
                                (~{aluInput_1[31], aluInput_1} & {aluInput_2[31], aluInput_2}));

        `ALU_OP_XOR:
            tempResult <= {aluInput_1[31], aluInput_1} ^ {aluInput_2[31], aluInput_2};

        `ALU_OP_SLL:
            tempResult <= {aluInput_2[31], aluInput_2} << sa;

        `ALU_OP_SRL:
            tempResult <= {aluInput_2[31], aluInput_2} >> sa;

        `ALU_OP_DEFAULT:
            tempResult <= {aluInput_2[31], aluInput_2};
    endcase
end
endmodule
