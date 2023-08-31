vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../../pipeline_cpu_riscv.srcs/sources_1/ip/ila_data/hdl/verilog" \
"D:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../pipeline_cpu_riscv.srcs/sources_1/ip/ila_data/hdl/verilog" \
"../../../../pipeline_cpu_riscv.srcs/sources_1/ip/ila_data/sim/ila_data.v" \

vlog -work xil_defaultlib \
"glbl.v"

