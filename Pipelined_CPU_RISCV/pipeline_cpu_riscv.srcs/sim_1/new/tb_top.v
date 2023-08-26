`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/26 22:03:50
// Design Name: 
// Module Name: tb_top
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


module tb_top(

    );
    reg clk;
    reg rst_n;
    wire [7:0] o_px;
    wire [6:0] o_led;
    
   top top( .clk (clk ),
            .rst_n (rst_n ),
            .o_px(o_px),
            .o_led(o_led)
            );

    initial begin

        rst_n = 1;
        clk = 0;

        #30 rst_n = 0;

        #30 rst_n = 1;

    end

    always
        #20 clk = ~clk;

endmodule
