`timescale 1ns / 1ps


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

    clk_50M clk_50m(
    .clk_50(clk_50),     // output clk_50M
    .reset(rst), // input reset
    .locked(locked),       // output locked
    .clk_in1(clk));      // input clk_in1
    
    CPU cpu(
        clk,
        rst,
        io_addr,
        data1,
        data2,
        data3,
        data4,
        data5,
        io_data
    );

    LightShow ls(
        clk,
        rst_n,
        data1,
        data2,
        data3,
        data4,
        data5,
        o_px,
        o_led_1,
        o_led_2
    );
    
    rs232 rs(
        clk_50, 
        rst_n, 
        rx,
        io_data,   
        io_addr,
        tx
    );
    
ila_data ila (
	.clk(clk), // input wire clk
	.probe0(data1), // input wire [3:0]  probe0  
	.probe1(data2), // input wire [3:0]  probe1 
	.probe2(data3) // input wire [3:0]  probe2
);

endmodule
