`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/24 15:37:52
// Design Name: 
// Module Name: ImmGen
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


module Imm_gen(
    input [31:0] ins,
    output reg [31:0] imm
);

always@(*) begin
    case(ins[6:0])
       7'b0010011: begin
           if(ins[14:12] == 3'b000) begin //addi
               if(ins[31] == 1)
                   imm = {20'hfffff,ins[31:20]};
               else 
                   imm =  {20'h0,ins[31:20]};
           end
           else if(ins[14:12] == 3'b001) begin //slli
               imm = {26'h0, ins[25:20]};
           end    
       end
       
       7'b0000011: begin//lw
           if(ins[31] == 1)
               imm = {20'hfffff,ins[31:20]};
           else imm =  {20'h0,ins[31:20]};
       end
       7'b0100011: begin//sw
           if(ins[31] == 1)
               imm = {20'hfffff,ins[31:25],ins[11:7]};
           else imm = {20'h0,ins[31:25],ins[11:7]};
       end
       7'b1100011: begin//beq
           if(ins[31] == 1) imm[31:13] = 19'h7ffff;
           else imm[31:13] = 19'h0;
           imm[12:0] = {ins[31],ins[7],ins[30:25],ins[11:8],1'b0};
       end
       7'b1101111: begin//jal
           if(ins[31] == 1) 
                imm = {11'h7ff,ins[31],ins[19:12],ins[20],ins[30:21],1'h0};
           else imm = {11'h0,ins[31],ins[19:12],ins[20],ins[30:21],1'h0};
       end      
    endcase
end      
endmodule
