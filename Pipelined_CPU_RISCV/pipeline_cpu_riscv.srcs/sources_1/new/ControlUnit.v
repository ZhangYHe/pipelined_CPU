`timescale 1ns / 1ps
`include "HeadFile.vh"


module ControlUnit(
    input [6:0] opcode,
    input [6:0] func7,
    input [2:0] func3,
    input halt,
    input stall,
    output reg is_jal,
    output reg is_beq,
    output reg is_bge,
    output reg [1:0] regS, //写回数据选择信号
    output reg [`ALU_OP_LENGTH - 1:0] ALUop, //ALU操作数
    output reg memWe, //DataMem写使能
    output reg ALUsrc, //操作数选择信号
    output reg regWe //寄存器堆写使能
);

always @(*) begin
    if(halt||stall) begin
           ALUop = `ALU_OP_ADD;
           is_jal = 0;
           is_beq = 0;
           is_bge = 0;
           regS = 0;
           memWe = 0;
           ALUsrc = 0;
           regWe = 0;
    end

    else begin
    case(opcode) 
        7'b0000000: begin //null 
            ALUop = `ALU_OP_ADD;
            is_jal = 0;
            is_beq = 0;
            is_bge = 0;
            regS = 0;
            memWe = 0;
            ALUsrc = 0;
            regWe = 0;
        end

        7'b0110011: begin 
            if (func7 == 7'b0100000) begin // sub
                ALUop = `ALU_OP_SUB;
            end
            else if (func7 == 7'b0000000) begin
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

            is_jal = 0;
            is_beq = 0;
            is_bge = 0;
            regS = 0;
            memWe = 0;
            ALUsrc = 0;
            regWe = 1;         
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

            is_jal = 0;
            is_beq = 0;
            is_bge = 0;
            regS = 0;
            memWe = 0;
            ALUsrc = 1;
            regWe = 1;
        end

        7'b0000011: begin// lw
            ALUop = `ALU_OP_ADD;
            is_jal = 0;
            is_beq = 0;
            is_bge = 0;
            regS = 1;
            memWe = 0;
            ALUsrc = 1;
            regWe = 1;
        end

        7'b0100011: begin // sw
            ALUop = `ALU_OP_ADD;
            is_jal = 0;
            is_beq = 0;
            is_bge = 0;
            regS = 0;
            memWe = 1;
            ALUsrc = 1;
            regWe = 0;
            
        end

        7'b1100011: begin
            if (func3 == 3'b000) begin// beq
                is_beq = 1;
                is_bge = 0;
            end
            else if (func3 == 3'b101) begin //bge
                is_beq = 0;
                is_bge = 1;
            end

            ALUop = `ALU_OP_SUB;
            is_jal = 0;
            regS = 2;
            memWe = 0;
            ALUsrc = 0;
            regWe = 0;
        end
       
        7'b1101111: begin //jal
            ALUop = `ALU_OP_ADD;
            is_jal = 1;
            is_beq = 0;
            is_bge = 0;
            regS = 2;
            memWe = 0;
            ALUsrc = 0;
            regWe = 1;
        end
    endcase
    end
end                
endmodule