# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {C:/Users/Yan Lijun/Desktop/lab6/project_lab6/project_lab6.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Yan Lijun/Desktop/lab6/project_lab6/project_lab6.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {c:/Users/Yan Lijun/Desktop/lab6/project_lab6/project_lab6.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files {{C:/Users/Yan Lijun/Desktop/lab6/riscvtest.coe}}
read_verilog -library xil_defaultlib {
  {C:/Users/Yan Lijun/Desktop/lab6/alupart.v}
  {C:/Users/Yan Lijun/Desktop/lab6/bcd2bin.v}
  {C:/Users/Yan Lijun/Desktop/lab6/bin2bcd.v}
  {C:/Users/Yan Lijun/Desktop/lab6/display_7seg.v}
  {C:/Users/Yan Lijun/Desktop/lab6/dmem_io.v}
  {C:/Users/Yan Lijun/Desktop/lab6/riscvparts.v}
  {C:/Users/Yan Lijun/Desktop/lab6/singleriscv.v}
  {C:/Users/Yan Lijun/Desktop/lab6/singleriscv_fpga.v}
}
read_ip -quiet {{C:/Users/Yan Lijun/Desktop/lab6/project_lab6/project_lab6.srcs/sources_1/ip/imem_fpga/imem_fpga.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/Yan Lijun/Desktop/lab6/project_lab6/project_lab6.srcs/sources_1/ip/imem_fpga/imem_fpga_ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Yan Lijun/Desktop/lab6/singleriscv.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Yan Lijun/Desktop/lab6/singleriscv.xdc}}]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top singleriscv_fpga -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef singleriscv_fpga.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file singleriscv_fpga_utilization_synth.rpt -pb singleriscv_fpga_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
