`timescale 1ns / 1ps
`include "head_file.vh"
//////////////////////////////////////////////////////////////////////////////////
//Input:  .clk .rst .npc
//Output: .pc 
//Company: 
// Engineer: 
// 
// Create Date: 2023/08/22 20:21:13
// Design Name: 
// Module Name: pc
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


module pc(
           input  wire       clk,
           input  wire       rst,
           input  wire[31:0] npc,

           input  wire[3:0]  stall_C,

           output reg[31:0]  pc
       );

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        pc <= `INIT_32;
    end
    else if(stall_C[0] == 0) begin
        pc <= npc;
    end
    else begin

    end
end
endmodule
