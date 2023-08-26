`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/26 16:14:12
// Design Name: 
// Module Name: tb_LightShow
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
    //reg [31:0] io_din = 32'h00000000;
    
    // CPU cpu(
    //               .clk (clk ),
    //               .rst (rst ),
    //               .io_din(io_din)
    //           );

    // test mul
    // reg [3:0] opc = 3'b110;
    // reg[31:0] sr1 = 8;
    // reg[31:0] sr2 = 7;
    // reg zero;
    // reg less;
    // reg [31:0] res;

    // ALU alu(.opc(opc),.sr1(sr1),.sr2(sr2),.zero(zero),.less(less),.res(res));
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
        //io_din = 32'b0;

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
