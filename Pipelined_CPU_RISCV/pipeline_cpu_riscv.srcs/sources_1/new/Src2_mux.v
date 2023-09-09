`timescale 1ns / 1ps
`include "HeadFile.vh"


module Src2_mux(
    input [1:0] f2,
    input [31:0] rd2,
    input [31:0] ME_res,
    input [31:0] WB_rfd,
    output reg [31:0] alu_d2
);

always@(*) begin
    case(f2)
        `SRC_RD: alu_d2 = rd2;
        `SRC_WB: alu_d2 = WB_rfd;
        `SRC_ME: alu_d2 = ME_res;
    endcase
end

endmodule