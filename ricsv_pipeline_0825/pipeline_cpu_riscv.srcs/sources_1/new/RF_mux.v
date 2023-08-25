`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:59:06
// Design Name: 
// Module Name: RF_mux
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


module RF_mux(
    input [1:0] regS,
    input [31:0] PC,
    input [31:0] dm,
    input [31:0] res,
    output reg [31:0] rf_d
);

always@(*) begin
    case(regS) 
       0: rf_d = res;//ALU结果
       1: rf_d = dm;//数据存储器
       2: rf_d = PC;//PC+4
    endcase
end

endmodule
