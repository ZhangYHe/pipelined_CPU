`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/22 20:56:04
// Design Name: 
// Module Name: MUX_REGSRC
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

module MUX_REGSRC(
    input wire[`REG_SRC_LENGTH - 1:0] RegSrc,  
    input wire[31:0]                  mux_in_0, 
    input wire[31:0]                  mux_in_1, 
    input wire[31:0]                  mux_in_2, 
    input wire[31:0]                  mux_in_3, 

    output reg[31:0]                  mux_out   
    );
    always @ (*) begin
        case (RegSrc)
            `REG_SRC_ALU:
                mux_out <= mux_in_0;
            `REG_SRC_MEM:
                mux_out <= mux_in_1;
            `REG_SRC_IMM:
                mux_out <= mux_in_2;
            `REG_SRC_NPC:
                mux_out <= mux_in_3;    // ?? 有问题
            default:
                mux_out <= mux_in_0;
        endcase
    end
endmodule
