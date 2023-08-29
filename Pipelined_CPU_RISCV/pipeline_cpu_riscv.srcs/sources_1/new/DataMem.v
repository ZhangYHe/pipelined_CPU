`timescale 1ns / 1ps


module DataMem(
    input clk, rst, we,
    input [7:0] addr,
    input [7:0] io_addr, // 8位外设输入
    input [31:0] wd,
    output [31:0] rd,
    output [7:0] io_rd, // 8位外设输出
    output [3:0] data1, // LightShow展示数字
    output [3:0] data2,
    output [3:0] data3,
    output [3:0] data4,
    output [3:0] data5
);

reg [31:0] datamem [255:0];

initial begin 
    datamem[0] <= 32'd9;
    datamem[1] <= 32'd1;
    datamem[2] <= 32'd3;
    datamem[3] <= 32'd7;
    datamem[4] <= 32'd2; 
end

assign rd = datamem[addr];
assign io_rd = datamem[io_addr][7:0];
assign data1 = datamem[0][3:0];
assign data2 = datamem[1][3:0];
assign data3 = datamem[2][3:0];
assign data4 = datamem[3][3:0];
assign data5 = datamem[4][3:0];

always @(posedge clk) begin
    if (we) begin
        datamem[addr] <= wd;
    end
end

endmodule