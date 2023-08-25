`timescale 1ns / 1ps
`include "head_file.vh"

// Module: PC Program Counter
//
// Input:  .RST .CLK .npc .stall_c .hazard
// Output: .pc
 
module PC(
           input  wire       RST, // Reset siganl
           input  wire       CLK, // Clock
           input  wire[31:0] npc, // Next Program Counter from module NPC
           input  wire[3:0]  stall_C, // Stall signal
           input             hazard, //
           
           output reg[31:0]  pc // Program Counter
       );

always @ (posedge CLK or posedge RST) begin
    if (RST) begin
        pc <= `INIT_32;
    end
    else if(stall_C[0] == 0) begin
        pc <= npc;
    end
    else begin

    end
end
endmodule
