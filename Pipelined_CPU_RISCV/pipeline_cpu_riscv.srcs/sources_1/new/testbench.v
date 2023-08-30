`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 19:13:12
// Design Name: 
// Module Name: testbench
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


module testbench(

    );
    reg clk;
    reg rst;
    reg [31:0] io_din = 32'h00000000;
    
    CPU cpu(
                  .clk (clk ),
                  .rst (rst ),
                  .io_din(io_din)
              );

    // test mul
    // reg [3:0] opc = 3'b110;
    // reg[31:0] sr1 = 8;
    // reg[31:0] sr2 = 7;
    // reg zero;
    // reg less;
    // reg [31:0] res;

    // ALU alu(.opc(opc),.sr1(sr1),.sr2(sr2),.zero(zero),.less(less),.res(res));

    initial begin

        rst = 1;
        clk = 0;
        io_din = 32'b0;

        #30 rst = 0;

    end

    always
        #20 clk = ~clk;

endmodule
