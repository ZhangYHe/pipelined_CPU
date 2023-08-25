`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 16:01:39
// Design Name: 
// Module Name: DataMem_mux
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


module DataMem_mux(
    input io_we,
    input [31:0] rd1,
    input [31:0] io_in,
    output reg [31:0] dm_out
);

always@(*) begin
    if(io_we) dm_out = io_in;
    else dm_out = rd1;
end

endmodule
