module master_example ( 
	CLOCK_50 , SW , KEY, LEDG, LEDR , DRAM_CLK, DRAM_CKE, DRAM_ADDR ,
	DRAM_BA,  DRAM_CS_N , DRAM_CAS_N , DRAM_RAS_N, DRAM_WE_N, 
	DRAM_DQ, DRAM_DQM , HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);		
	

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


	//parameter ADDRESSWIDTH = 32 ;
	parameter ADDRESSWIDTH = 8;
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
//
	logic [31:0] display_data;
/* 
pll pll_inst(
	.inclk0( CLOCK_50) ,
	.c1( temp_vga_clk ) ,
	.c0(DRAM_CLK ) ,	
	.c2( soc_clk) );
*/
	
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

amm_master_qsys amm_master_inst  ( 
                .clk_clk				(soc_clk),  				  // clk.clk
                .reset_reset_n				( KEY[0]),                  	          // reset.reset_n
                
		.new_sdram_controller_0_wire_addr	(DRAM_ADDR),         			  // new_sdram_controller_0_wire.addr
                .new_sdram_controller_0_wire_ba		(DRAM_BA),           			  // ba
                .new_sdram_controller_0_wire_cas_n	(DRAM_CAS_N),        			  // cas_n
                .new_sdram_controller_0_wire_cke	(DRAM_CKE),          			  // cke
                .new_sdram_controller_0_wire_cs_n	(DRAM_CS_N),         			  // cs_n
                .new_sdram_controller_0_wire_dq		(DRAM_DQ),           			  // dq
                .new_sdram_controller_0_wire_dqm	(DRAM_DQM),          			  // dqm
                .new_sdram_controller_0_wire_ras_n	(DRAM_RAS_N),        			  // ras_n
                .new_sdram_controller_0_wire_we_n	(DRAM_WE_N),         			  // we_n
					 
                .write_master_control_fixed_location	(ctl_wr_fixed_location),		  // write_master_control.fixed_location
                .write_master_control_write_base	(ctl_wr_addr_base),    			  // write_base
                .write_master_control_write_length	(ctl_wr_length),   			  // write_length

                .write_master_control_go		(ctl_wr_go),             		  // go
                .write_master_control_done		(ctl_wr_done),           		  // done
                .write_master_user_write_buffer		(usr_wr_buffer),      			  // write_master_user.write_buffer
                .write_master_user_buffer_input_data	(usr_wr_buffer_data), 			  // buffer_input_data
                .write_master_user_buffer_full		(usr_wr_buffer_full),       		  // buffer_full
					 
		.read_master_control_fixed_location	(ctl_rd_fixed_location),		  //read_master_control.fixed_location
		.read_master_control_read_base		(ctl_rd_addr_base),		          //read_base
		.read_master_control_read_length	(ctl_rd_length),			  //read_length

		.read_master_control_go			(ctl_rd_go),				  //go
		.read_master_control_done		(ctl_rd_done),				  //done
		.read_master_user_read_buffer		(usr_rd_buffer),			  //read_master_user.read_buffer
		.read_master_user_buffer_output_data	(usr_rd_buffer_data),			  //buffer_output_data
		.read_master_user_data_available	(usr_rd_buffer_nonempty)		  //data_available
        );


user_logic user_logic_inst (
	.clk(soc_clk),
	.reset(KEY[0]),
	.rdwr_cntl(SW[17]),
	.n_action(KEY[1]),
	.read_address(SW[7:0]),
	.display_data(display_data),
	.write_control_fixed_location(ctl_wr_fixed_location),
	.write_control_write_base(ctl_wr_addr_base),
	.write_control_write_length(ctl_wr_length),

	.write_control_go(ctl_wr_go),
	.write_control_done(ctl_wr_done),

	.write_user_write_buffer(usr_wr_buffer),
	.write_user_buffer_data(usr_wr_buffer_data),
	.write_user_buffer_full(usr_wr_buffer_full),

	.read_control_fixed_location(ctl_rd_fixed_location),
	.read_control_read_base(ctl_rd_addr_base),
	.read_control_read_length(ctl_rd_length),

	.read_control_go(ctl_rd_go),
	.read_control_done(ctl_rd_done),

	.read_user_read_buffer(usr_rd_buffer),
	.read_user_buffer_output_data(usr_rd_buffer_data),
	.read_user_data_available(usr_rd_buffer_nonempty)
	
);
SEG_HEX hex0(
	   .iDIG(display_data[31:28]),         
	   .oHEX_D(HEX7)
           );  
SEG_HEX hex1(                              
           .iDIG(display_data[27:24]),
           .oHEX_D(HEX6)
           );
SEG_HEX hex2(                           
           .iDIG(display_data[23:20]),
           .oHEX_D(HEX5)
           );
SEG_HEX hex3(                              
           .iDIG(display_data[19:16]),
           .oHEX_D(HEX4)
           );
SEG_HEX hex4(                               
           .iDIG(display_data[15:12]),
           .oHEX_D(HEX3)
           );
SEG_HEX hex5(                          
           .iDIG(display_data[11:8]), 
           .oHEX_D(HEX2)
           );
SEG_HEX hex6(                      
           .iDIG(display_data[7:4]),
           .oHEX_D(HEX1)
           );
SEG_HEX hex7(              
           .iDIG(display_data[3:0]) ,
           .oHEX_D(HEX0)
           );

endmodule 
