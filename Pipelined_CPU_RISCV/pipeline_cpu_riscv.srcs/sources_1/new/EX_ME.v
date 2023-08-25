`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:42:40
// Design Name: 
// Module Name: EX_ME
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


module EX_ME(
    input clk,
    input RegW,
    input [1:0] regS,
    input MemWr,
    input [31:0] PC4,
    input [31:0] res,
    input [4:0] dr,
    input [31:0] rfd,
  
    output reg ME_RegW,
    output reg [1:0] ME_regS,
    output reg ME_MemWr,
    output reg [31:0] ME_PC4,
    output reg [31:0] ME_res,
    output reg [4:0] ME_dr,
    output reg [31:0] ME_rfd
);

always @(posedge clk) begin
    ME_RegW <= RegW;
    ME_regS <= regS;
    ME_MemWr <= MemWr;
    ME_PC4 <= PC4;
    ME_res <= res;
    ME_dr <= dr;
    ME_rfd <= rfd;
end

endmodule
