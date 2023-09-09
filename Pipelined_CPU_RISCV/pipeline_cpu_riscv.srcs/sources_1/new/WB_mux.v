`timescale 1ns / 1ps
`include "HeadFile.vh"


module WB_mux(
    input [1:0] regS,
    input [31:0] PC,
    input [31:0] dm,
    input [31:0] res,
    output reg [31:0] wbData
);

always@(*) begin
    case(regS) 
        `WB_RES: wbData = res; //ALU���
        `WB_DM: wbData = dm; //���ݴ洢��
        `WB_PC: wbData = PC; //PC+4
    endcase
end

endmodule
