`timescale 1ns / 1ps
`include "head_file.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/23 13:10:55
// Design Name: 
// Module Name: reg_if_id
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


module reg_if_id(
           input  wire       clk,
           input  wire       rst,
           input  wire[31:0] instructions_in,
           input  wire[3:0]  stall_C,

           output reg[31:0]  instructions_out
       );

// if rst/halt, zeroize all registers
wire zeroize;
assign zeroize = rst;

always @ (posedge clk) begin
    if (zeroize) begin
        instructions_out <= `INIT_32;
    end
    else if(stall_C[1] == 0) begin
        instructions_out <= instructions_in;
    end
    else begin
        // do nothing
    end
end

endmodule
