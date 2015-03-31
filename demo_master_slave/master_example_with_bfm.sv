module master_example ( 
	CLOCK_50 , 
	SW , 
	KEY, 
	LEDG, 
	LEDR , 
	// DRAM signals
	DRAM_CLK, 
	DRAM_CKE, 
	DRAM_ADDR ,
	
	DRAM_BA ,
	DRAM_CS_N ,
	DRAM_CAS_N , 
	DRAM_RAS_N , 
	DRAM_WE_N, 
	DRAM_DQ ,
	DRAM_DQM ,
	
	// HEX 7 SEG DISPLAY
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6, 
	HEX7,
	// PCIE signals
	PCIE_PERST_N,
	PCIE_REFCLK_P,
	PCIE_RX_P,
	PCIE_TX_P,
	PCIE_WAKE_N
);		
	

input logic  CLOCK_50  ;
input logic [17:0] SW ; 
input logic [3:0] KEY ;
output logic [8:0] LEDG; 
output logic [17:0]LEDR;
output logic [6:0] HEX0;
output logic [6:0] HEX1;
output logic [6:0] HEX2;
output logic [6:0] HEX3;
output logic [6:0] HEX4;
output logic [6:0] HEX5;
output logic [6:0] HEX6;
output logic [6:0] HEX7;

output logic [11:0]DRAM_ADDR;
output logic [1:0]DRAM_BA;
output logic DRAM_CAS_N;
output logic DRAM_CKE;
output logic DRAM_CLK;
output logic DRAM_CS_N;
inout	logic  [31:0] DRAM_DQ;
output logic [3:0] DRAM_DQM;
output logic DRAM_RAS_N;
output logic DRAM_WE_N;

input logic PCIE_PERST_N;
input logic PCIE_REFCLK_P;
input logic PCIE_RX_P;
output logic PCIE_TX_P;
output logic PCIE_WAKE_N;

//parameter ADDRESSWIDTH = 32 ;
parameter ADDRESSWIDTH = 28;
parameter DATAWIDTH = 32;

logic soc_clk;
logic ctl_wr_fixed_location;
logic [ADDRESSWIDTH-1:0] ctl_wr_addr_base;
logic [ADDRESSWIDTH-1:0] ctl_wr_length;

logic ctl_rd_fixed_location;
logic [ADDRESSWIDTH-1:0] ctl_rd_addr_base;
logic [ADDRESSWIDTH-1:0] ctl_rd_length;

logic ctl_wr_go;
logic ctl_wr_done;

logic usr_wr_buffer;
logic [DATAWIDTH-1:0]usr_wr_buffer_data;
logic usr_wr_buffer_full;

logic ctl_rd_go;
logic ctl_rd_done;

logic usr_rd_buffer;
logic [DATAWIDTH-1:0]usr_rd_buffer_data;
logic usr_rd_buffer_nonempty;
logic [31:0] display_data;
/* 
pll pll_inst(
	.inclk0( CLOCK_50) ,
	.c1( temp_vga_clk ) ,
	.c0(DRAM_CLK ) ,	
	.c2( soc_clk) );
*/
	
assign PCIE_WAKE_N = 1'b1;

assign soc_clk = CLOCK_50;


assign DRAM_CLK = CLOCK_50;

	
always_ff @(posedge CLOCK_50) begin
	if(!KEY[0]) begin
		LEDG <= 0; 
	end else begin
		if (ctl_rd_go == 1) begin
			LEDG[0] <= 1;
		end
		if (ctl_rd_done == 1) begin
			LEDG[1] <= 1;
		end
		if (usr_rd_buffer_nonempty == 1) begin
			LEDG[2] <= 1;
		end
		if (ctl_wr_go == 1) begin
			LEDG[7] <= 1;
		end
		if (ctl_wr_done == 1) begin
			LEDG[6] <= 1;
		end
		if (usr_wr_buffer_data == 32'hFFFFFFFF) begin
			LEDG[5] <= 1;
		end	
	end
end	

amm_master_qsys_custom_with_bfm u0 (
        .clk_clk                            (soc_clk), 
        .reset_reset_n                      (KEY[0]), 
        .custom_module_conduit_rdwr_cntl    (SW[17]), 
        .custom_module_conduit_n_action     (KEY[1]), 
        .custom_module_conduit_add_data_sel (SW[16]),
        .custom_module_conduit_rdwr_address (SW[15:0])
    );


//IB// user_logic user_logic_inst (
//IB// 	.clk				(soc_clk),
//IB// 	.reset				(KEY[0]),
//IB// 	.rdwr_cntl			(SW[17]),
//IB// 	.n_action			(KEY[1]),
//IB// 	.add_data_sel			(SW[16]),
//IB// 	.rdwr_address			(SW[15:0]),
//IB// 	.display_data			(display_data),
//IB// 	.write_control_fixed_location	(ctl_wr_fixed_location),
//IB// 	.write_control_write_base	(ctl_wr_addr_base),
//IB// 	.write_control_write_length	(ctl_wr_length),
//IB// 
//IB// 	.write_control_go		(ctl_wr_go),
//IB// 	.write_control_done		(ctl_wr_done),
//IB// 
//IB// 	.write_user_write_buffer	(usr_wr_buffer),
//IB// 	.write_user_buffer_data		(usr_wr_buffer_data),
//IB// 	.write_user_buffer_full		(usr_wr_buffer_full),
//IB// 
//IB// 	.read_control_fixed_location	(ctl_rd_fixed_location),
//IB// 	.read_control_read_base		(ctl_rd_addr_base),
//IB// 	.read_control_read_length	(ctl_rd_length),
//IB// 
//IB// 	.read_control_go		(ctl_rd_go),
//IB// 	.read_control_done		(ctl_rd_done),
//IB// 
//IB// 	.read_user_read_buffer		(usr_rd_buffer),
//IB// 	.read_user_buffer_output_data	(usr_rd_buffer_data),
//IB// 	.read_user_data_available	(usr_rd_buffer_nonempty)
//IB// );


//amm_master_qsys amm_master_inst  ( 
//IB// amm_master_qsys_with_pcie amm_master_inst  ( 
//IB// 	.clk_clk				(soc_clk),  				  // clk.clk
//IB// 	.reset_reset_n				(KEY[0]),                  	          // reset.reset_n
//IB// //	.altpll_sdram_clk               	(DRAM_CLK),
//IB// 	.sdram_addr				(DRAM_ADDR),         			  // new_sdram_controller_0_wire.addr
//IB// 	.sdram_ba				(DRAM_BA),           			  // ba
//IB// 	.sdram_cas_n				(DRAM_CAS_N),        			  // cas_n
//IB// 	.sdram_cke				(DRAM_CKE),          			  // cke
//IB// 	.sdram_cs_n				(DRAM_CS_N),         			  // cs_n
//IB// 	.sdram_dq				(DRAM_DQ),           			  // dq
//IB// 	.sdram_dqm				(DRAM_DQM),          			  // dqm
//IB// 	.sdram_ras_n				(DRAM_RAS_N),        			  // ras_n
//IB// 	.sdram_we_n				(DRAM_WE_N),         			  // we_n
//IB// 				 
//IB// 	.write_master_control_fixed_location	(ctl_wr_fixed_location),		  // write_master_control.fixed_location
//IB// 	.write_master_control_write_base	(ctl_wr_addr_base),    			  // write_base
//IB// 	.write_master_control_write_length	(ctl_wr_length),   			  // write_length
//IB// 	
//IB// 	.write_master_control_go		(ctl_wr_go),             		  // go
//IB// 	.write_master_control_done		(ctl_wr_done),           		  // done
//IB// 	.write_master_user_write_buffer		(usr_wr_buffer),      			  // write_master_user.write_buffer
//IB// 	.write_master_user_buffer_input_data	(usr_wr_buffer_data), 			  // buffer_input_data
//IB// 	.write_master_user_buffer_full		(usr_wr_buffer_full),       		  // buffer_full
//IB// 				 
//IB// 	.read_master_control_fixed_location	(ctl_rd_fixed_location),		  //read_master_control.fixed_location
//IB// 	.read_master_control_read_base		(ctl_rd_addr_base),		          //read_base
//IB// 	.read_master_control_read_length	(ctl_rd_length),			  //read_length
//IB// 	
//IB// 	.read_master_control_go			(ctl_rd_go),				  //go
//IB// 	.read_master_control_done		(ctl_rd_done),				  //done
//IB// 	.read_master_user_read_buffer		(usr_rd_buffer),			  //read_master_user.read_buffer
//IB// 	.read_master_user_buffer_output_data	(usr_rd_buffer_data),			  //buffer_output_data
//IB// 	.read_master_user_data_available	(usr_rd_buffer_nonempty),		  //data_available
//IB// 	
//IB// 	.pcie_ip_refclk_export           	(PCIE_REFCLK_P),                      // pcie_ip_refclk.export
//IB// 	.pcie_ip_pcie_rstn_export        	(PCIE_PERST_N),             	  // pcie_ip_pcie_rstn.export
//IB// 	.pcie_ip_rx_in_rx_datain_0       	(PCIE_RX_P),                          // pcie_ip_rx_in.rx_datain_0
//IB// 	.pcie_ip_tx_out_tx_dataout_0     	(PCIE_TX_P)                           // pcie_ip_tx_out.tx_dataout_0
//IB// );
//IB// 
//IB// 
//IB// 
//IB// SEG_HEX hex0(
//IB// 	   .iDIG(display_data[31:28]),         
//IB// 	   .oHEX_D(HEX7)
//IB//            );  
//IB// SEG_HEX hex1(                              
//IB//            .iDIG(display_data[27:24]),
//IB//            .oHEX_D(HEX6)
//IB//            );
//IB// SEG_HEX hex2(                           
//IB//            .iDIG(display_data[23:20]),
//IB//            .oHEX_D(HEX5)
//IB//            );
//IB// SEG_HEX hex3(                              
//IB//            .iDIG(display_data[19:16]),
//IB//            .oHEX_D(HEX4)
//IB//            );
//IB// SEG_HEX hex4(                               
//IB//            .iDIG(display_data[15:12]),
//IB//            .oHEX_D(HEX3)
//IB//            );
//IB// SEG_HEX hex5(                          
//IB//            .iDIG(display_data[11:8]), 
//IB//            .oHEX_D(HEX2)
//IB//            );
//IB// SEG_HEX hex6(                      
//IB//            .iDIG(display_data[7:4]),
//IB//            .oHEX_D(HEX1)
//IB//            );
//IB// SEG_HEX hex7(              
//IB//            .iDIG(display_data[3:0]) ,
//IB//            .oHEX_D(HEX0)
//IB//            );

endmodule 
