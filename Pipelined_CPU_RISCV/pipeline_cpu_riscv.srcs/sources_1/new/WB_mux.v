`timescale 1ns / 1ps


module WB_mux(
    input [1:0] regS,
    input [31:0] PC,
    input [31:0] dm,
    input [31:0] res,
    output reg [31:0] wbData
);

always@(*) begin
    case(regS) 
        0: wbData = res; //ALU���
        1: wbData = dm; //���ݴ洢��
        2: wbData = PC; //PC+4
    endcase
end

endmodule
