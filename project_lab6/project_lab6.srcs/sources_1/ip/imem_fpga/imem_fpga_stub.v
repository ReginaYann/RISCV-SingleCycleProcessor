// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue Dec 29 09:59:42 2020
// Host        : LAPTOP-1F1BK33S running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/Yan
//               Lijun/Desktop/lab6/project_lab6/project_lab6.srcs/sources_1/ip/imem_fpga/imem_fpga_stub.v}
// Design      : imem_fpga
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.2" *)
module imem_fpga(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[5:0],spo[31:0]" */;
  input [5:0]a;
  output [31:0]spo;
endmodule
