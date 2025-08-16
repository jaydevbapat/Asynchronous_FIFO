module Sync_write_to_read (output reg [7:0] sync_write_pointer,
		      input [7:0] write_pointer,
		      input clock_read, read_reset_n);
				 
	reg [7:0] t_pointer;
	
	// 2 flop synchronizer for write point with respect to read clock
	always @(posedge clock_read or negedge read_reset_n)
		if (!read_reset_n) 
			{sync_write_pointer, t_pointer} <= 0;
		else 
			{sync_write_pointer, t_pointer} <= {t_pointer, write_pointer};
			
endmodule
