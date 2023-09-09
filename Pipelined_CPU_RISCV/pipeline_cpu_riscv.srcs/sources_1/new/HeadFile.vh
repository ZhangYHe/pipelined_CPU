`define PC_INIT_ADDR    32'h3000

// ALUop
`define ALU_OP_LENGTH   4          
`define ALU_OP_ADD      4'b0000    
`define ALU_OP_SUB      4'b0001    
`define ALU_OP_SLT      4'b0010    
`define ALU_OP_AND      4'b0011    
`define ALU_OP_OR       4'b0100    
`define ALU_OP_XOR      4'b0101    
`define ALU_OP_SLL      4'b0110    
`define ALU_OP_SRL      4'b0111
`define ALU_OP_MUL      4'b1000

// Src
`define SRC_RD          2'b00
`define SRC_WB          2'b01
`define SRC_ME          2'b10

// WB_MUX
`define WB_RES          2'b00
`define WB_DM           2'b01
`define WB_PC           2'b10