module top_level(
	input logic CLOCK_50,

//switches and pushbuttons
	input logic [17:0] SW,
	input logic [3:0] KEY,

//LED display signals
	output logic [17:0] LEDR,
	output logic [8:0] LEDG,

//SSRAM signals
	inout wire [31:0] FS_DQ,
	output logic [26:0] FS_ADDR,
	output logic SSRAM0_CE_N,
	output logic SSRAM1_CE_N,
	output logic SSRAM_ADSC_N,
	output logic SSRAM_ADSP_N,
	output logic SSRAM_ADV_N,
	output logic [3:0] SSRAM_BE,
	output logic SSRAM_CLK,
	output logic SSRAM_GW_N, // asserted through
	output logic SSRAM_OE_N,
	output logic SSRAM_WE_N
);
//----------------------------------------------------------------------------
//CLOCKING SIGNALS
//May have to mess with PLL to get the clock you are looking for
//----------------------------------------------------------------------------

logic SYSTEM_CLOCK;
logic SKEW_CLOCK;

pll_clk_gen PLL_GEN(
	.clk_clk(CLOCK_50),
	.clk_pll_clk(SYSTEM_CLOCK),
	.clk_skw_clk(SKEW_CLOCK)
);
/*
assign SYSTEM_CLOCK = CLOCK_50;
assign SKEW_CLOCK = SYSTEM_CLOCK;
*/
//----------------------------------------------------------------------------
//SYNCHRONIZERS AND EDGE DETECTORS
//use _SYNC and _NEGEDGE for ALL real time signals!
//----------------------------------------------------------------------------

//Switch Synchronizer ->
logic [17:0] SW_ASYNC;
logic [17:0] SW_SYNC;
always_ff @ (posedge SYSTEM_CLOCK) begin
	SW_ASYNC <= SW;
	SW_SYNC <= SW_ASYNC;
end

	
//Push Button Synchronizer -> 
logic [3:0] PB_ASYNC;
logic [3:0] PB_SYNC;
always_ff @ (posedge SYSTEM_CLOCK) begin
	PB_ASYNC <= KEY;
	PB_SYNC <= PB_ASYNC;
end

//Push Button edge detector ->
logic [3:0] PB_CURR;
logic [3:0] PB_NEGEDGE;
always_ff @ (posedge SYSTEM_CLOCK) begin
	PB_CURR <= PB_SYNC;
end

assign PB_NEGEDGE = (PB_SYNC & ~PB_CURR);

//----------------------------------------------------------------------------
//SHORT TOP LEVEL CODE ->
//Follow KISS or you may have a LOT of debugging issues!
//----------------------------------------------------------------------------
	
//----------------------------------------------------------------------------
//LEDG INDICATORS, CLOCKING SIGNALS
//Ever real time signal or event should get an LED assignment
//----------------------------------------------------------------------------

assign SSRAM_CLK = SKEW_CLOCK;//might need to find skew
assign LEDG[7:6] = (!KEY[3])? '1:'0;
assign LEDG[5:4] = (!KEY[2])? '1:'0;
assign LEDG[3:2] = (!KEY[1])? '1:'0;
assign LEDG[1] = (!KEY[0])? '1:'0;


logic wen;
logic [19:0] wAddr;
logic [31:0] wData;

logic ren = 1'b0;
logic [19:0] rAddr;
logic [31:0] rData;
logic write_done;

logic [31:0] dataBus;
logic [31:0] nextDataBus;

assign LEDR[17:0] = SW[17:0];
assign LEDG[0] = write_done;

sram_wrapper SRAM(
	.CLOCK(SYSTEM_CLOCK),
	//.SKEW_CLK(SKEW_CLOCK),
	.nRST(!PB_NEGEDGE[3]),
	//.nRST(KEY[3]),
	.wen(wen ),
	.wAddr(wAddr ),
	.wData(wData ),
	.ren(ren),
	.rAddr(rAddr),
	.rData(rData),
	.FS_DQ(FS_DQ),
	.FS_ADDR(FS_ADDR),
	.SSRAM0_CE_N(SSRAM0_CE_N),
	.SSRAM1_CE_N(SSRAM1_CE_N),
	.SSRAM_ADSC_N(SSRAM_ADSC_N),
	.SSRAM_ADSP_N(SSRAM_ADSP_N),
	.SSRAM_ADV_N(SSRAM_ADV_N),
	.SSRAM_BE(SSRAM_BE),
	//.SSRAM_CLK(SSRAM_CLK),
	.SSRAM_GW_N(SSRAM_GW_N),
	.SSRAM_OE_N(SSRAM_OE_N),
	.SSRAM_WE_N(SSRAM_WE_N)

);

logic [9:0] r_ram_s1_address;
logic r_ram_s1_chipselect;
logic r_ram_s1_clken;
logic r_ram_s1_write;
logic [31:0] r_ram_s1_writedata;
logic [3:0] r_ram_s1_byteenable;

/*onchip_ram ONCHIP(
	.clk_clk(SYSTEM_CLOCK),
	.reset_reset_n(!PB_NEGEDGE[3]),
	//.reset_reset_n(KEY[3]),
	.r_ram_s1_address( r_ram_s1_address ),
	.r_ram_s1_chipselect( r_ram_s1_chipselect ),
	.r_ram_s1_clken( r_ram_s1_clken),
	.r_ram_s1_write( r_ram_s1_write ),
	.r_ram_s1_writedata( r_ram_s1_writedata),
	.r_ram_s1_byteenable( r_ram_s1_byteenable)
);*/
/*	
sram_read READ(
	.CLOCK(SYSTEM_CLOCK),
	//.nRST(!PB_NEGEDGE[3]),
	.nRST(KEY[3]),
	.start( write_done ),
	.ren(ren),
	.rAddr(rAddr),
	.rData(rData ),
	.r_ram_s1_address( r_ram_s1_address),
	.r_ram_s1_chipselect( r_ram_s1_chipselect),
	.r_ram_s1_clken( r_ram_s1_clken),
	.r_ram_s1_write( r_ram_s1_write),
	.r_ram_s1_writedata( r_ram_s1_writedata),
	.r_ram_s1_byteenable( r_ram_s1_byteenable)
);
*/
logic [31:0] bitMask;
//assign bitMask = {SW_SYNC[17:10], SW_SYNC[16:9], SW_SYNC[15:8], SW_SYNC[14:7] };
assign bitMask = 32'hFFFFFFFF ;
//assign bitMask = {14'b1, SW_SYNC[17:0]  };
sram_write WRITE(
	.CLOCK(SYSTEM_CLOCK),
	.nRST(!PB_NEGEDGE[3]),
	.start(SW[0]),
	.bitMask(bitMask),
	.done(write_done),
	.wen(wen),
	.wAddr(wAddr),
	.wData(wData)
);


endmodule

