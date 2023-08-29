`timescale 1ns / 1ps


module ForwardUnit(
	input [1:0] ME_regS,
    input [4:0] ME_dr, WB_dr,
    input  ME_RegW, WB_RegW,
    input [4:0] EX_rs1, EX_rs2,
    output reg [1:0] rs_f1,
    output reg [1:0] rs_f2
);

initial begin
	rs_f1 <= 0; 
	rs_f2 <= 0; 
end

always@(*) begin
    //rs_f2
    if (ME_RegW && (ME_dr != 0) && (ME_dr == EX_rs1)) begin //·Ã´æ½×¶Î³åÍ»
    	rs_f1 = 2;
	end
    else if (WB_RegW &&(WB_dr != 0) && !(ME_RegW && (ME_dr != 0) 
	&& (ME_dr == EX_rs1)) && (WB_dr == EX_rs1)) begin //Ð´»Ø½×¶Î³åÍ»
       rs_f1 = 1;
	end
    else begin
		rs_f1 = 0;
	end
    
    //rs_f2
    if (ME_RegW && (ME_dr != 0) && (ME_dr == EX_rs2)) begin
       rs_f2 = 2;
	end
    else if(WB_RegW && (WB_dr != 0) && !(ME_RegW && (ME_dr != 0) 
	&& (ME_dr == EX_rs2)) && (WB_dr == EX_rs2)) begin
       rs_f2 = 1;
	end
    else begin
		rs_f2 = 0;
	end
end

endmodule
