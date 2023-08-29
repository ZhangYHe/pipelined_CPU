`timescale 1ns / 1ps


module RegFile(
    input clk,rst,
    input [4:0] r1,
    input [4:0] r2,
    input we,
    input [4:0] wreg,
    input [31:0] wd,
    output reg [31:0] rd1,
    output reg [31:0] rd2
);

reg [31:0] regFile [0:31];
integer i;

wire eq1,eq2; //信号量，写与读寄存器是否相等
assign eq1 = (r1 == wreg)? 1 : 0;
assign eq2 = (r2 == wreg)? 1 : 0;

initial 
	for(i = 0; i < 32; i = i + 1) 
		regFile[i] <= 0;

always @(*) begin //写优先
	if(eq1 && (wreg > 0)) 
		rd1 = wd;
    else 
		rd1 = regFile[r1];
    if(eq2 && (wreg > 0)) 
		rd2 = wd;
    else 
		rd2 = regFile[r2];
end

always @(posedge clk) begin
    if(rst) begin
    	for(i = 0; i < 32; i = i + 1) begin 
    		regFile[i] <= 0; 
      	end
    end
    else if(we && (wreg > 0)) 
		regFile[wreg] <= wd;
end
endmodule
