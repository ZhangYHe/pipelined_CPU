`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/26 16:15:35
// Design Name: 
// Module Name: top
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


module top(
    input clk, 
    input rst,
    output [7:0] o_px,    
    output [6:0] o_led    
    );
    
    CPU cpu(clk,rst,data1,data2,data3,data4,data5);
    LightShow ls(clk,data1,data2,data3,data4,data5,o_px,o_led);
    
endmodule
