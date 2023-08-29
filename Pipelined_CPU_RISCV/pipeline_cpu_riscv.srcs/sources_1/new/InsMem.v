`timescale 1ns / 1ps


module InsMem(
	input clk,we,
    input [31:0] ins_d,
    input [9:0] addr,
    input flush, //清空信号
    output reg [31:0] insOut //输出指令
);

wire [31:0] insTemp;

//IP核
instruction_mem my_insmem (
	.a(addr),      // input wire [9 : 0] a
	.d(ins_d),      // input wire [31 : 0] d
	.clk(clk),  // input wire clk
	.we(we),    // input wire we
	.spo(insTemp)  // output wire [31 : 0] spo
);

always @(*) begin
    if(flush) 
		insOut = 0;
    else 
		insOut = insTemp;
end

endmodule
