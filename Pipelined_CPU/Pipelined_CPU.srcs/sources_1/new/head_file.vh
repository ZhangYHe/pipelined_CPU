
`define INIT_32         32'h00000000

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