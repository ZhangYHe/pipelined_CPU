`timescale 1ns / 1ps


module ImmGen(
    input [31:0] insCode,
    output reg [31:0] imm
);

always@(*) begin
    case(insCode[6:0])
        7'b0010011: begin
            if(insCode[14:12] == 3'b000) begin // addi
                if(insCode[31] == 1) begin
                    imm = {20'hfffff,insCode[31:20]};
                end
                else begin
                    imm =  {20'h0,insCode[31:20]};
                end
            end
            else if(insCode[14:12] == 3'b001) begin // slli
                imm = {26'h0, insCode[25:20]};
            end
            else if (insCode[14:12] == 3'b101) begin // srli
                imm = {26'h0, insCode[25:20]};
            end  
        end
       
        7'b0000011: begin // lw
            if(insCode[31] == 1) begin
                imm = {20'hfffff,insCode[31:20]};
            end
            else begin
                imm =  {20'h0,insCode[31:20]};
            end
        end

        7'b0100011: begin // sw
            if(insCode[31] == 1) begin
                imm = {20'hfffff,insCode[31:25],insCode[11:7]};
            end
            else begin
                imm = {20'h0,insCode[31:25],insCode[11:7]};
            end 
        end

        7'b1101111: begin // jal
            if(insCode[31] == 1) begin
                imm = {11'h7ff,insCode[31],insCode[19:12],insCode[20],insCode[30:21],1'h0};
            end
            else begin
                imm = {11'h0,insCode[31],insCode[19:12],insCode[20],insCode[30:21],1'h0};
            end
        end

        7'b1100011: begin // beq bge
            if(insCode[31] == 1) begin
                imm[31:13] = 19'h7ffff;
            end 
            else begin
                imm[31:13] = 19'h0;
            end
            imm[12:0] = {insCode[31],insCode[7],insCode[30:25],insCode[11:8],1'b0};
        end
    
    endcase
end      
endmodule
