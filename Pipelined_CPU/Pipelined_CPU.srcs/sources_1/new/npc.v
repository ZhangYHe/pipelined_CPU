`timescale 1ns / 1ps
`include "head_file.vh"
//////////////////////////////////////////////////////////////////////////////////
// Input:  .clk .pc .imm16 .imm26 .reg1_data .cu_npc
// Output: .npc
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/22 20:26:11
// Design Name: 
// Module Name: npc
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


module npc(
           input  wire[31:0]                  pc,
           input  wire[15:0]                  imm16,     // 16 bit immediate
           input  wire[25:0]                  imm26,     // 26 bit immediate
           input  wire[31:0]                  reg1_data, // rs data
           
           input  wire[`NPC_LENGTH  - 1:0] cu_npc, // NPC control signal

           output wire[31:0]                  npc,       // next program counter
           output wire[31:0]                  jmp_dst    // JAL, JAJR jump dst
       );

wire[31:0] pc_4;
assign pc_4 = pc + 32'h4;

assign jmp_dst = pc + 32'h8;

assign npc =
       (cu_npc == `NPC_NEXT  ) ? pc_4 :                                       // pc + 4
       (cu_npc == `NPC_JUMP  ) ? {pc[31:28], imm26, 2'b00} :                  // pc = target
       (cu_npc == `NPC_OFFSET) ? {pc_4 + {{14{imm16[15]}}, {imm16, 2'b00}}} : // pc + 4 + offset
       (cu_npc == `NPC_RS    ) ? reg1_data :                                  // pc = rs data
       pc_4;                                                                        // fallback mode: pc + 4
endmodule
