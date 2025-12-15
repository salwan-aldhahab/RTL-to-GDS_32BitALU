# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.17-s066_1 on Fri Dec 12 02:51:35 EST 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design alu_1bit

create_clock -name "clk" -period 1000.0 -waveform {0.0 500.0} 
set_load -pin_load 4.0 [get_ports f_o]
set_load -pin_load 4.0 [get_ports cout_o]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 0.01 [get_ports {sel_i[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.01 [get_ports {sel_i[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.01 [get_ports {sel_i[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.01 [get_ports {sel_i[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.01 [get_ports cin_i]
set_input_delay -clock [get_clocks clk] -add_delay 0.01 [get_ports b_i]
set_input_delay -clock [get_clocks clk] -add_delay 0.01 [get_ports a_i]
set_output_delay -clock [get_clocks clk] -add_delay 0.03 [get_ports cout_o]
set_output_delay -clock [get_clocks clk] -add_delay 0.03 [get_ports f_o]
set_max_fanout 5.000 [get_ports a_i]
set_max_fanout 5.000 [get_ports b_i]
set_max_fanout 5.000 [get_ports cin_i]
set_max_fanout 5.000 [get_ports {sel_i[3]}]
set_max_fanout 5.000 [get_ports {sel_i[2]}]
set_max_fanout 5.000 [get_ports {sel_i[1]}]
set_max_fanout 5.000 [get_ports {sel_i[0]}]
set_drive 2.0 [get_ports a_i]
set_drive 2.0 [get_ports b_i]
set_drive 2.0 [get_ports cin_i]
set_drive 2.0 [get_ports {sel_i[3]}]
set_drive 2.0 [get_ports {sel_i[2]}]
set_drive 2.0 [get_ports {sel_i[1]}]
set_drive 2.0 [get_ports {sel_i[0]}]
set_wire_load_mode "enclosed"
