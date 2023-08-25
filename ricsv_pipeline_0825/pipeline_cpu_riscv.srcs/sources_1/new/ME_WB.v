`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:58:31
// Design Name: 
// Module Name: ME_WB
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


module ME_WB(
    input clk,
    input RegW,
    input [1:0] regS,
    input [31:0] PC,
    input [31:0] dm_rd1,
    input [31:0] res,
    input [4:0] dr,
    input [31:0] rf_d2,

    output reg WB_RegW,
    output reg [1:0] WB_regS,
    output reg [31:0] WB_PC,
    output reg [31:0] WB_dm_rd1,
    output reg [31:0] WB_res,
    output reg [4:0] WB_dr,
    output reg [31:0] WB_rf_d2  //没用
);
always@(posedge clk) begin
    WB_RegW <= RegW;
    WB_regS <= regS;
    WB_PC <= PC;
    WB_dm_rd1 <= dm_rd1;
    WB_res <= res;
    WB_dr <= dr;
end

endmodule
