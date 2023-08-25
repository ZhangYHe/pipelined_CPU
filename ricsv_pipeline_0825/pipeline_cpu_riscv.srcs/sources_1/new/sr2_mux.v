module sr2_mux(
    input [1:0] f2,
    input [31:0] rd2,
    input [31:0] ME_res,
    input [31:0] WB_rfd,
    output reg [31:0] alu_d2
);

always@(*) begin
    case(f2)
        2: alu_d2 = ME_res;
        1: alu_d2 = WB_rfd;
        0: alu_d2 = rd2;
    endcase
end

endmodule