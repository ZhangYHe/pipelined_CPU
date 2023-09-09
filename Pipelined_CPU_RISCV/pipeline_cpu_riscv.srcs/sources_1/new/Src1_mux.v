`timescale 1ns / 1ps
`include "HeadFile.vh"


module Src1_mux(
    input [1:0] f1,
    input [31:0] rd1,
    input [31:0] ME_res,
    input [31:0] WB_rfd,
    output reg [31:0] alu_d1
);

always@(*) begin
    case(f1)
        `SRC_RD: alu_d1 = rd1;
        `SRC_WB: alu_d1 = WB_rfd; //WB������
        `SRC_ME: alu_d1 = ME_res; //MEM����������   
    endcase
end

endmodule
