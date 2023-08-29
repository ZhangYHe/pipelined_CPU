`timescale 1ns / 1ps


module REG_IF_ID(
    input clk,rst,
    input [31:0] IF_PC,
    input [31:0] IF_PC4,
    input [31:0] IF_ins,
    input halt,flush,
    output reg [31:0] ID_PC, 
    output reg [31:0] ID_PC4, 
    output reg [31:0] ID_ins
);

always @(posedge clk) begin
    if(halt) begin //load-use halt
        ID_ins <= ID_ins;
        ID_PC <= ID_PC;
        ID_PC4 <= ID_PC4;
    end
    else if(flush) 
        ID_ins <= 0; //分支时清空
    else begin
        ID_ins <= IF_ins;
        ID_PC <= IF_PC;
        ID_PC4 <= IF_PC4;
    end
end

endmodule
