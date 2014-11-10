
# (C) 2001-2014 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 13.0sp1 232 linux 2014.11.05.17:16:47

# ----------------------------------------
# vcsmx - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="onchip_ver_qsys_tb"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="/package/eda/altera/altera13.0sp1/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/onchip_memory2_0_s1_translator/
mkdir -p ./libraries/read_master_avalon_master_translator/
mkdir -p ./libraries/onchip_memory2_0/
mkdir -p ./libraries/write_master/
mkdir -p ./libraries/onchip_ver_qsys_inst_reset_bfm/
mkdir -p ./libraries/onchip_ver_qsys_inst_clk_bfm/
mkdir -p ./libraries/onchip_ver_qsys_inst/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/cycloneiv_hssi_ver/
mkdir -p ./libraries/cycloneiv_pcie_hip_ver/
mkdir -p ./libraries/cycloneiv_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/onchip_ver_qsys_onchip_memory2_0.hex ./
fi

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"        -work altera_ver            
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                 -work lpm_ver               
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                    -work sgate_ver             
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                -work altera_mf_ver         
  vlogan +v2k -sverilog "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"            -work altera_lnsim_ver      
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneiv_hssi_atoms.v"     -work cycloneiv_hssi_ver    
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneiv_pcie_hip_atoms.v" -work cycloneiv_pcie_hip_ver
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneiv_atoms.v"          -work cycloneiv_ver         
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  vlogan +v2k           "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/altera_reset_controller.v"          -work rst_controller                      
  vlogan +v2k           "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/altera_reset_synchronizer.v"        -work rst_controller                      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/altera_merlin_slave_translator.sv"  -work onchip_memory2_0_s1_translator      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/altera_merlin_master_translator.sv" -work read_master_avalon_master_translator
  vlogan +v2k           "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/onchip_ver_qsys_onchip_memory2_0.v" -work onchip_memory2_0                    
  vlogan +v2k           "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/custom_master.v"                    -work write_master                        
  vlogan +v2k           "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/burst_write_master.v"               -work write_master                        
  vlogan +v2k           "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/burst_read_master.v"                -work write_master                        
  vlogan +v2k           "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/write_master.v"                     -work write_master                        
  vlogan +v2k           "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/latency_aware_read_master.v"        -work write_master                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/verbosity_pkg.sv"                   -work onchip_ver_qsys_inst_reset_bfm      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/altera_avalon_reset_source.sv"      -work onchip_ver_qsys_inst_reset_bfm      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/verbosity_pkg.sv"                   -work onchip_ver_qsys_inst_clk_bfm        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/altera_avalon_clock_source.sv"      -work onchip_ver_qsys_inst_clk_bfm        
  vlogan +v2k           "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/submodules/onchip_ver_qsys.v"                  -work onchip_ver_qsys_inst                
  vlogan +v2k           "$QSYS_SIMDIR/onchip_ver_qsys_tb/simulation/onchip_ver_qsys_tb.v"                                                                    
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  vcs -lca -t ps $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $USER_DEFINED_SIM_OPTIONS
fi
