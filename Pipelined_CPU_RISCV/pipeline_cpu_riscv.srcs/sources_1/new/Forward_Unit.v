`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:59:54
// Design Name: 
// Module Name: Forward_Unit
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


module Forward_Unit(
    input [1:0] ME_regS,
    input [4:0] ME_dr, WB_dr,
    input  ME_RegW, WB_RegW,
    input [4:0] EX_rs1, EX_rs2,
    output reg [1:0] rs1_f,
    output reg [1:0] rs2_f
);
initial begin
rs1_f <= 0; rs2_f <= 0; 
end

always@(*) begin
    //rs1f
    if(ME_RegW &&
    (ME_dr != 0) && (ME_dr == EX_rs1))//ME阶段冲突
       rs1_f = 2;
    else if(WB_RegW &&
    (WB_dr != 0) && !(ME_RegW && (ME_dr != 0) && (ME_dr == EX_rs1)) &&
    (WB_dr == EX_rs1))//写回阶段冲突
       rs1_f = 1;
    else rs1_f = 0;
    
    //rs2f
    if(ME_RegW &&
    (ME_dr != 0) && (ME_dr == EX_rs2))
       rs2_f = 2;
    else if(WB_RegW &&
    (WB_dr != 0) && !(ME_RegW && (ME_dr != 0) && (ME_dr == EX_rs2)) &&
    (WB_dr == EX_rs2))
       rs2_f = 1;
    else rs2_f = 0;
end

endmodule
