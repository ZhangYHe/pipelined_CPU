-makelib ies_lib/xpm -sv \
  "D:/Vivado/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Vivado/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Vivado/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/dist_mem_gen_v8_0_13 \
  "../../../ipstatic/simulation/dist_mem_gen_v8_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../pipeline_cpu_riscv.srcs/sources_1/ip/instruction_mem_1/sim/instruction_mem.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

