`timescale 1ns / 1ps


module Src1_mux(
    input [1:0] f1,
    input [31:0] rd1,
    input [31:0] ME_res,
    input [31:0] WB_rfd,
    output reg [31:0] alu_d1
);

always@(*) begin
    case(f1)
        0: alu_d1 = rd1;
        1: alu_d1 = WB_rfd; //WB的数据
        2: alu_d1 = ME_res; //MEM读出的数据   
    endcase
end

endmodule
