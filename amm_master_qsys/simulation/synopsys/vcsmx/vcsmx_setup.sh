
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

# ACDS 13.0sp1 232 linux 2014.11.03.12:20:51

# ----------------------------------------
# vcsmx - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="amm_master_qsys"
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
mkdir -p ./libraries/rsp_xbar_demux/
mkdir -p ./libraries/cmd_xbar_mux/
mkdir -p ./libraries/cmd_xbar_demux/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/id_router/
mkdir -p ./libraries/addr_router/
mkdir -p ./libraries/new_sdram_controller_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo/
mkdir -p ./libraries/new_sdram_controller_0_s1_translator_avalon_universal_slave_0_agent/
mkdir -p ./libraries/write_master_avalon_master_translator_avalon_universal_master_0_agent/
mkdir -p ./libraries/new_sdram_controller_0_s1_translator/
mkdir -p ./libraries/write_master_avalon_master_translator/
mkdir -p ./libraries/write_master/
mkdir -p ./libraries/new_sdram_controller_0/
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
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/amm_master_qsys_rsp_xbar_demux.sv"        -work rsp_xbar_demux                                                              
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"              -work cmd_xbar_mux                                                                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/amm_master_qsys_cmd_xbar_mux.sv"          -work cmd_xbar_mux                                                                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/amm_master_qsys_cmd_xbar_demux.sv"        -work cmd_xbar_demux                                                              
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                -work rst_controller                                                              
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"              -work rst_controller                                                              
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/amm_master_qsys_id_router.sv"             -work id_router                                                                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/amm_master_qsys_addr_router.sv"           -work addr_router                                                                 
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                  -work new_sdram_controller_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"             -work new_sdram_controller_0_s1_translator_avalon_universal_slave_0_agent         
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"      -work new_sdram_controller_0_s1_translator_avalon_universal_slave_0_agent         
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"            -work write_master_avalon_master_translator_avalon_universal_master_0_agent       
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"        -work new_sdram_controller_0_s1_translator                                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"       -work write_master_avalon_master_translator                                       
  vlogan +v2k           "$QSYS_SIMDIR/submodules/custom_master.v"                          -work write_master                                                                
  vlogan +v2k           "$QSYS_SIMDIR/submodules/burst_write_master.v"                     -work write_master                                                                
  vlogan +v2k           "$QSYS_SIMDIR/submodules/burst_read_master.v"                      -work write_master                                                                
  vlogan +v2k           "$QSYS_SIMDIR/submodules/write_master.v"                           -work write_master                                                                
  vlogan +v2k           "$QSYS_SIMDIR/submodules/latency_aware_read_master.v"              -work write_master                                                                
  vlogan +v2k           "$QSYS_SIMDIR/submodules/amm_master_qsys_new_sdram_controller_0.v" -work new_sdram_controller_0                                                      
  vlogan +v2k           "$QSYS_SIMDIR/amm_master_qsys.v"                                                                                                                     
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
