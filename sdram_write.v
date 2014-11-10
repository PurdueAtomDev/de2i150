/* sdram_write.v - Avalon MM Master component to do simple writes to the SDRAM*/

module write_master (
	clk,
	reset,

// Signals that map to Avalon Master Interface
	address,
	write_n,
	byteenable,
	writedata,
	waitrequest
);

parameter ADDRESSWIDTH = 25 ;
parameter DATAWIDTH    = 32 ;
parameter BYTEENABLEWIDTH  = 4;

input logic clk;
input logic reset;

input logic waitrequest;
output logic [ADDRESSWIDTH-1:0] address;
output logic write_n;
output logic [BYTEENABLEWIDTH-1:0] byteenable;
output logic [DATAWIDTH-1:0] writedata;

typedef enum {IDLE, WRITE} state_t;
state_t state, next_state;

assign writedata = 32'hDEADBEEF;
assign write = (state == WRITE);
assign byteenable = 4'b1111 ;

always @ (posedge clk or posedge reset)
begin 
	if (reset)
	begin 
		address <= 32'b0;
		state <= IDLE;
	end
	else 
	begin 
		address <= next_address;
		state <= next_state;
	end
end


always_comb begin 
	case(state)
		IDLE: begin 
			next_state = WRITE;
			next_address = address + 1;
		end 
		WRITE: begin 
			if(!waitrequest) 
				next_state = IDLE;	
		end 
	endcase
end


endmodule
