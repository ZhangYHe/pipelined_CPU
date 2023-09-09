`timescale 1ns / 1ps


module HazardUnit(
    input do_jmp,
    input memrd,
    input [4:0] rs1,rs2,dr,
    output reg halt, //load-use halt
    output reg flush //Ìø×ª Çå¿Õ
);

initial begin
    halt <= 0; 
    flush <= 0;
end

always@(*) begin
    halt = 0; 
    flush = 0;
    if((memrd && ((dr == rs1) || (dr == rs2)))) begin //load use
       halt = 1;
    end
    if(do_jmp) begin
        flush = 1;
    end
    
end
endmodule