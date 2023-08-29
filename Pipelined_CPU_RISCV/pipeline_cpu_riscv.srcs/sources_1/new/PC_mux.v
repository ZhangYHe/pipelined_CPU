`timescale 1ns / 1ps


module PC_mux(
    input [31:0] PC_in,
    input [31:0] imm,
    input [31:0] IF_PC,
    input br,
    output [31:0] PC_imm,
    output [31:0] PC4,
    output reg [31:0] PC_out
);

assign PC_imm = PC_in + imm;
assign PC4 = IF_PC + 4;

always@(*) begin
    if(br) 
        PC_out = PC_in + imm; //发生分支后计算的新PC
    else 
        PC_out = IF_PC + 4; //正常加4
end
endmodule
