
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name AirPurifier -dir "C:/Users/Phol/Documents/ComHardAssignment/planAhead_run_2" -part xc6slx9tqg144-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "C:/Users/Phol/Documents/ComHardAssignment/AirPurifier/main.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {AirPurifier/uart.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {AirPurifier/pwm.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {AirPurifier/main.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top main $srcset
add_files [list {C:/Users/Phol/Documents/ComHardAssignment/AirPurifier/main.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx9tqg144-3
