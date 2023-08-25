`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:39:15
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [3:0] opc,
    input [31:0] sr1,
    input [31:0] sr2,
    output zero,
    output less,
    output reg [31:0] res
);

assign zero = (res == 0)? 1:0;
assign less = res[31];

always@(*) begin
    case(opc)
       0: res = sr1 + sr2;
       1: res = sr1 - sr2;
       2: res = sr1 << sr2;
       3: res = sr1 & sr2;
       4: res = (sr1 == sr2)? 1:0;
       5: res = (sr1 < sr2)? 1:0;
       6: res = sr1 * sr2;
    endcase
end
endmodule
