module ALU_mux(
    input [31:0] regData,
    input [31:0] imm,
    input ALUsrc,
    output reg [31:0] data
);

always@(*) begin
    if(ALUsrc) begin
        data = imm;
    end
    else begin
        data = regData;
    end
end

endmodule