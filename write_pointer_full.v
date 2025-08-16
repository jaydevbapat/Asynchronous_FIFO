module write_pointer_full (output reg full,
		     output [6:0] write_address,
		     output reg [7:0] write_pointer,
		     input [7:0] sync_read_pointer,
		     input write_enable, clock_write, write_reset_n);
	
	reg [7:0] write_binary;
	wire [7:0] write_gray_next, write_binary_next;
	wire full_val;
	
	// Gray Style 2 pointer (both gray code and binary code registers are present)
	always @(posedge clock_write or negedge write_reset_n)
	if (!write_reset_n) 
		{write_binary, write_pointer} <= 0;
	else
		{write_binary, write_pointer} <= {write_binary_next, write_gray_next};
	
	assign write_binary_next = write_binary + (write_enable & ~full);
	assign write_gray_next = (write_binary_next>>1) ^ write_binary_next;
	
	// Memory write-address pointer (binary is used to address memory)
	assign write_address = write_binary[6:0];
	
	// Simplified version of the three necessary full-tests:
	
	// assign full_val=((write_gray_next[6] != sync_read_pointer[6]) &&
	//		    (write_gray_next[5] != sync_read_pointer[5]) && 
	//   		    (write_gray_next[4:0] == sync_read_pointer[4:0]));
	
	
	assign full_val = (write_gray_next=={~sync_read_pointer[7:6], sync_read_pointer[5:0]});
	
	always @(posedge clock_write or negedge write_reset_n)
		if (!write_reset_n) 
			full <= 1'b0;
		else 
			full <= full_val;
	
endmodule
