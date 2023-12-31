
`define INIT_32         32'h00000000

// EX
// ALUSrc 寄存器文件/立即数
`define ALU_SRC_REG     1'b0
`define ALU_SRC_IMM     1'b1

// ALU 控制信号
`define ALU_OP_LENGTH   4          // Length of ALUOp
`define ALU_OP_DEFAULT  4'b0000    // default value
`define ALU_OP_ADD      4'b0001    // add
`define ALU_OP_SUB      4'b0010    // sub
`define ALU_OP_SLT      4'b0011    // slt
`define ALU_OP_AND      4'b0100    // and
`define ALU_OP_OR       4'b0101    // or
`define ALU_OP_XOR      4'b0110    // xor
`define ALU_OP_NOR      4'b0111    // nor
`define ALU_OP_SLL      4'b1000    // sll
`define ALU_OP_SRL      4'b1001    // srl

// WB
`define REG_SRC_LENGTH      3
`define REG_SRC_DEFAULT     3'b000      
`define REG_SRC_ALU         3'b001     
`define REG_SRC_MEM         3'b010      
`define REG_SRC_IMM         3'b011      
`define REG_SRC_PC_JMP      3'b100      

// Controls Singals
`define NPC_LENGTH   3          
`define NPCP_DEFAULT  3'b000     
`define NPC_NEXT     3'b001     
`define NPC_JUMP     3'b010     
`define NPC_OFFSET   3'b011     
`define NPC_RS       3'b100   

`define REG_WRITE_ENABLE    1'b1       
`define REG_WRITE_DISABLE   1'b0      

`define LW_ENABLE     1'b0

