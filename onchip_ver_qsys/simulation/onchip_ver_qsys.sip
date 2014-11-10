set_global_assignment -entity "onchip_ver_qsys" -library "lib_onchip_ver_qsys" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "onchip_ver_qsys" -library "lib_onchip_ver_qsys" -name IP_TOOL_VERSION "13.0sp1"
set_global_assignment -entity "onchip_ver_qsys" -library "lib_onchip_ver_qsys" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_onchip_ver_qsys" -name SPD_FILE [file join $::quartus(sip_path) "../../onchip_ver_qsys.spd"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "../../onchip_ver_qsys.qsys"]

set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "onchip_ver_qsys.v"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_slave_translator.sv"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_master_translator.sv"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/onchip_ver_qsys_onchip_memory2_0.v"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/onchip_ver_qsys_onchip_memory2_0.hex"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/custom_master.v"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/burst_write_master.v"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/burst_read_master.v"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/write_master.v"]
set_global_assignment -library "lib_onchip_ver_qsys" -name MISC_FILE [file join $::quartus(sip_path) "submodules/latency_aware_read_master.v"]
