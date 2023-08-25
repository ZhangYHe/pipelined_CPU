`timescale 1ns / 1ps
`include "head_file.vh"

// Module: REF_IF_ID Register_IF_ID
// 
// Input: .RST .CLK .inst_in .stall_C .reg1_data .hazard
// Output: .inst_out

module REG_IF_ID(
           input  wire       RST,
           input  wire       CLK,
           input  wire[31:0] inst_in,
           input  wire[3:0]  stall_C,
           input  wire[31:0] reg1_data,
           input             hazard,

           output reg[31:0]  inst_out
       );

//Zeroize flag, 1 for zeroize
wire ZeroFlag;
assign ZeroFlag = RST;
// If rst/halt, set all registers zero
always @ (posedge CLK) begin
    if (ZeroFlag) begin
        inst_out <= `INIT_32;
    end
    else if(stall_C[1] == 0) begin
        inst_out <= inst_in;
    end
    else begin

    end
end

endmodule
