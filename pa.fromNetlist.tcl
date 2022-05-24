
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name AirPurifier -dir "C:/Users/Phol/Documents/ComHardAssignment/planAhead_run_1" -part xc6slx9tqg144-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Phol/Documents/ComHardAssignment/main.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Phol/Documents/ComHardAssignment} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "C:/Users/Phol/Documents/ComHardAssignment/AirPurifier/main.ucf" [current_fileset -constrset]
add_files [list {C:/Users/Phol/Documents/ComHardAssignment/AirPurifier/main.ucf}] -fileset [get_property constrset [current_run]]
link_design
