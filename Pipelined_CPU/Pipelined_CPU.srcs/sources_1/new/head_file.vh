
`define INIT_32         32'h00000000

// WB
`define REG_SRC_LENGTH      3
`define REG_SRC_DEFAULT     3'b000      
`define REG_SRC_ALU         3'b001     
`define REG_SRC_MEM         3'b010      
`define REG_SRC_IMM         3'b011      
`define REG_SRC_NPC         3'b100      

// NPCOp Control Signals
`define NPC_LENGTH   3          // Length of NPCOp
`define NPCP_DEFAULT  3'b000    // NPCOp default value
`define NPC_NEXT     3'b001     // Next instruction: {PC + 4}
`define NPC_JUMP     3'b010     // Next instruction: {PC[31:28], instr_index, 2'b00}
`define NPC_OFFSET   3'b011     // Next instruction: {PC + 4 + offset}
`define NPC_RS       3'b100     // Next instruction: {rs}