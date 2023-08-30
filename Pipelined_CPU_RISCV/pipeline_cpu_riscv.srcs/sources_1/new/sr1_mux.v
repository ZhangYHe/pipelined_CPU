`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:41:08
// Design Name: 
// Module Name: sr1_mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sr1_mux(
    input [1:0] f1,
    //input [31:0] ME_dmd,
    input [31:0] rd1,
    input [31:0] ME_res,
    input [31:0] WB_rfd,
    output reg [31:0] alu_d1
);

always@(*) begin
    case(f1)
        2: alu_d1 = ME_res;//MEM读出的数据
        1: alu_d1 = WB_rfd;//WB的数据
        0: alu_d1 = rd1;
    endcase
end

endmodule
