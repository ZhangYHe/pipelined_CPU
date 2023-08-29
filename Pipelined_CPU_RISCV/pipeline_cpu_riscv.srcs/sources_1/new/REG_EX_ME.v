`timescale 1ns / 1ps


module REG_EX_ME(
    input clk,
    input regWe,
    input [1:0] regS,
    input memWe,
    input [31:0] PC4,
    input [31:0] res,
    input [4:0] dr,
    input [31:0] rfd,
    output reg ME_regWe,
    output reg [1:0] ME_regS,
    output reg ME_memWe,
    output reg [31:0] ME_PC4,
    output reg [31:0] ME_res,
    output reg [4:0] ME_dr,
    output reg [31:0] ME_rfd
);

always @(posedge clk) begin
    ME_regWe <= regWe;
    ME_regS <= regS;
    ME_memWe <= memWe;
    ME_PC4 <= PC4;
    ME_res <= res;
    ME_dr <= dr;
    ME_rfd <= rfd;
end

endmodule
