`timescale 1ns / 1ps
`include "HeadFile.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:36:03
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input [6:0] opcode,
    input [6:0] func6,
    input [2:0] func3,
    input halt,
    input stall,
    output reg jal,
    output reg branch,
    output reg is_bge,
    output reg [1:0] regS,
    output reg [`ALU_OP_LENGTH - 1:0] ALUop,
    output reg MemWr,
    output reg ALUsrc,
    output reg RegW
);

always@(*) begin
    if(halt||stall) begin
           ALUop = `ALU_OP_ADD;
           jal = 0;
           branch = 0;
           is_bge = 0;
           regS = 0;
           MemWr = 0;
           ALUsrc = 0;
           RegW = 0;
    end

    else begin
    case(opcode) 
        7'b0000000: begin //null 
            ALUop = `ALU_OP_ADD;
            jal = 0;
            branch = 0;
            is_bge = 0;
            regS = 0;
            MemWr = 0;
            ALUsrc = 0;
            RegW = 0;
       end

        7'b0110011: begin 
            if (func6 == 7'b0100000) begin // sub
                ALUop = `ALU_OP_SUB;
            end
            else if (func6 == 7'b0000000) begin
                if (func3 == 3'b000) begin // add
                    ALUop = `ALU_OP_ADD;
                end
                else if (func3 == 3'b001) begin // sll
                    ALUop = `ALU_OP_SLL;
                end
                else if (func3 == 3'b010) begin // slt
                    ALUop = `ALU_OP_SLT;
                end
                else if (func3 == 3'b101) begin // srl
                    ALUop = `ALU_OP_SRL;
                end
                else if (func3 == 3'b100) begin // xor
                    ALUop = `ALU_OP_XOR;
                end
                else if (func3 == 3'b110) begin // or
                    ALUop = `ALU_OP_OR;
                end
                else if (func3 == 3'b111) begin // and
                    ALUop = `ALU_OP_AND;
                end
            end

            jal = 0;
            branch = 0;
            is_bge = 0;
            regS = 0;
            MemWr = 0;
            ALUsrc = 0;
            RegW = 1;         
        end

        7'b0010011: begin
            if (func3 == 3'b000) begin // addi    
                ALUop = `ALU_OP_ADD;
            end
            else if (func3 == 3'b001) begin // slli
                ALUop = `ALU_OP_SLL;
            end
            else if (func3 == 3'b101) begin //srli
                ALUop = `ALU_OP_SRL;
            end
            ALUop = 0;
            jal = 0;
            branch = 0;
            is_bge = 0;
            regS = 0;
            MemWr = 0;
            ALUsrc = 1;
            RegW = 1;
       end

        7'b0000011: begin// lw
            ALUop = 0;//+
            jal = 0;
            branch = 0;
            is_bge = 0;
            regS = 1;
            MemWr = 0;
            ALUsrc = 1;
            RegW = 1;
        end

        7'b0100011: begin // sw
            ALUop = 0;
            jal = 0;
            branch = 0;
            is_bge = 0;
            regS = 0;
            MemWr = 1;
            ALUsrc = 1;
            RegW = 0;
            
        end

        7'b1100011: begin
            if (func3 == 3'b000) begin// beq
                ALUop = 1;
                jal = 0;
                branch = 1;
                is_bge = 0;
                regS = 2;//PC+4
                MemWr = 0;
                ALUsrc = 0;//reg
                RegW = 0;
            end
            else if (func3 == 3'b101) begin //bge
                ALUop = 1;
                jal = 0;
                branch = 0;
                is_bge = 1;
                regS = 2;//PC+4
                MemWr = 0;
                ALUsrc = 0;//reg
                RegW = 0;
            end
       end
       
        7'b1101111: begin//jal
            ALUop = 0;
            jal = 1;
            branch = 0;
            is_bge = 0;
            regS = 2;//PC+4
            MemWr = 0;
            ALUsrc = 0;//Imm
            RegW = 1;
       end
    endcase
    end
end                
endmodule