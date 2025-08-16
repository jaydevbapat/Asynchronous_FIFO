module Sync_read_2_write (output reg [7:0] sync_read_pointer,
		      input [7:0] read_pointer,
		      input clock_write, write_reset_n);
				 
	reg [7:0] t_pointer;
	
	// 2 flop synchronizer for read point with respect to write clock
	always @(posedge clock_write or negedge write_reset_n)
		if (!write_reset_n) 
			{sync_read_pointer, t_pointer} <= 0;
		else 
			{sync_read_pointer, t_pointer} <= {t_pointer, read_pointer};
			
endmodule
