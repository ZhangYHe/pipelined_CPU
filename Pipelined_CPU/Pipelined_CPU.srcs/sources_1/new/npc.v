`timescale 1ns / 1ps
`include "head_file.vh"

// Module: NPC Next Program Counter
//
// Input:  .clk .pc .imm16 .imm26 .en_npc_op
// Output: .npc

module NPC(
           input  wire[31:0]                  PC,
           input  wire[15:0]                  imm16,     // 16 bit immediate
           input  wire[25:0]                  imm26,     // 26 bit immediate
           input  wire[31:0]                  REG1_Data, // register data
           
           input  wire[`NPC_LENGTH  - 1:0]    NPC_CTRL, // NPC control signal

           output wire[31:0]                  npc,       // next program counter
           output wire[31:0]                  jmp_dst    // JAL, JAJR jump dst
       );

wire[31:0] PC_4;
assign PC_4 = PC + 32'h4;

assign jmp_dst = PC + 32'h8;

assign npc =
       (NPC_CTRL == `NPC_NEXT  ) ? PC_4 :                                       // pc + 4
       (NPC_CTRL == `NPC_JUMP  ) ? {PC[31:28], imm26, 2'b00} :                  // pc = target
       (NPC_CTRL == `NPC_OFFSET) ? {PC_4 + {{14{imm16[15]}}, {imm16, 2'b00}}} : // pc + 4 + offset
       (NPC_CTRL == `NPC_RS    ) ? REG1_Data :                                  // pc = rs data
       PC_4;                                                                        // fallback mode: pc + 4
endmodule
