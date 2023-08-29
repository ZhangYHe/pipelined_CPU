`timescale 1ns / 1ps


module REG_ME_WB(
    input clk,
    input regWe,
    input [1:0] regS,
    input [31:0] PC,
    input [31:0] dm_rd,
    input [31:0] res,
    input [4:0] dr,
    output reg WB_regWe,
    output reg [1:0] WB_regS,
    output reg [31:0] WB_PC,
    output reg [31:0] WB_dm_rd,
    output reg [31:0] WB_res,
    output reg [4:0] WB_dr
);

always @(posedge clk) begin
    WB_regWe <= regWe;
    WB_regS <= regS;
    WB_PC <= PC;
    WB_dm_rd <= dm_rd;
    WB_res <= res;
    WB_dr <= dr;
end

endmodule
