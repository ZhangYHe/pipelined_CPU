// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_50M(clk_50, reset, locked, clk_in1);
  output clk_50;
  input reset;
  output locked;
  input clk_in1;
endmodule
