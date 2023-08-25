module ALU_mux(
    input [31:0] rd2,
    input [31:0] imm,
    input ALUsrc,
    output reg [31:0] data
);

always@(*) begin
    if(ALUsrc) data = imm;
    else data = rd2;
end

endmodule