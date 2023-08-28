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
    input rx,
    output [7:0] o_px,    
    output [6:0] o_led_1,
    output [6:0] o_led_2,
    output tx   
    );
    
    wire [3:0] data1;
    wire [3:0] data2;
    wire [3:0] data3; 
    wire [3:0] data4;
    wire [3:0] data5;
    wire [7:0] io_data;
    wire [7:0] io_addr;
    wire clk_50;
    wire rst;
    
    assign rst=~rst_n;

//    assign io_addr = 8'b0;
    clk_50M clk_50m(
    // Clock out ports
    .clk_50(clk_50),     // output clk_50M
    // Status and control signals
    .reset(rst), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk));      // input clk_in1
    
    CPU cpu(clk,rst,io_addr,data1,data2,data3,data4,data5,io_data);
    LightShow ls(clk,rst_n,data1,data2,data3,data4,data5,o_px,o_led_1,o_led_2);
    
    rs232 rs(
    clk_50, //系统时钟50MHz
    rst_n , //全局复位
    rx , //串口接收数据
    io_data,
    // input wire rx_en,
    // input wire tx_en,
    
    io_addr,
    tx //串口发送数据
    );
    
//    ila_0 your_instance_name (
//	.clk(clk), // input wire clk


//	.probe0(data1), // input wire [3:0]  probe0  
//	.probe1(data2), // input wire [3:0]  probe1 
//	.probe2(data3) // input wire [3:0]  probe2
//    );
endmodule
