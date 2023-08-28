// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Sun Aug 27 16:01:25 2023
// Host        : LAPTOP-ZMX running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Pipelined_CPU_RISCV/pipeline_cpu_riscv.srcs/sources_1/ip/clk_50M/clk_50M_stub.v
// Design      : clk_50M
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_50M(clk_50, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_50,reset,locked,clk_in1" */;
  output clk_50;
  input reset;
  output locked;
  input clk_in1;
endmodule
