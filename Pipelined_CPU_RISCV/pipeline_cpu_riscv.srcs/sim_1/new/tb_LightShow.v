`timescale 1ns / 1ps


module tb_LightShow(

    );
    reg clk;
    reg rst;
    reg [3:0] d1;
    reg [3:0] d2;
    reg [3:0] d3; 
    reg [3:0] d4;
    reg [3:0] d5;

    wire [7:0] px;
    wire [6:0] led ;
    
    LightShow ls(.clk (clk ),
                 .data_1(d1),
                 .data_2(d2),
                 .data_3(d3),
                 .data_4(d4),
                 .data_5(d5),
                 .o_px(px),
                 .o_led(led));

    initial begin

        rst = 1;
        clk = 0;

        #30 rst = 0;

        d1 = 4'h1;
        d2 = 4'h2;
        d3 = 4'h9;
        d4 = 4'h7;
        d5 = 4'h5;

    end

    always
        #20 clk = ~clk;
endmodule
