if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name max_timing\
   -timing\
    [list ${::IMEX::libVar}/mmmc/slow_vdd1v0_basicCells.lib\
    ${::IMEX::libVar}/mmmc/slow_vdd1v2_basicCells.lib]
create_library_set -name min_timing\
   -timing\
    [list ${::IMEX::libVar}/mmmc/fast_vdd1v2_basicCells.lib\
    ${::IMEX::libVar}/mmmc/fast_vdd1v0_basicCells.lib]
create_rc_corner -name rc_best\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0
create_rc_corner -name rc_worst\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0
create_delay_corner -name max_delay\
   -library_set max_timing\
   -rc_corner rc_best
create_delay_corner -name min_delay\
   -library_set min_timing\
   -rc_corner rc_worst
create_constraint_mode -name constraints\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/genus_alu_32bit_behavioral.sdc]
create_analysis_view -name best_case -constraint_mode constraints -delay_corner min_delay
create_analysis_view -name worst_case -constraint_mode constraints -delay_corner max_delay
set_analysis_view -setup [list worst_case] -hold [list best_case]
