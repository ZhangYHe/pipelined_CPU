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
    input rst_n,
    output [7:0] o_px,    
    output [6:0] o_led_1,
    output [6:0] o_led_2   
    );
    
    wire [3:0 ]data1;
    wire [3:0 ]data2;
    wire [3:0 ]data3; 
    wire [3:0 ]data4;
    wire [3:0 ]data5;

    wire rst;
    
    assign rst=~rst_n;
    
    CPU cpu(clk,rst,data1,data2,data3,data4,data5);
    LightShow ls(clk,rst_n,data1,data2,data3,data4,data5,o_px,o_led_1,o_led_2);
    
//    ila_0 your_instance_name (
//	.clk(clk), // input wire clk


//	.probe0(data1), // input wire [3:0]  probe0  
//	.probe1(data2), // input wire [3:0]  probe1 
//	.probe2(data3) // input wire [3:0]  probe2
//    );
endmodule
