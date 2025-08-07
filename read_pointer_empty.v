module read_pointer_empty (output reg empty,
		     output [5:0] read_address,
		     output reg [6:0] read_pointer,
		     input [6:0] sync_write_pointer,
		     input read_enable, clock_read, read_reset_n);
	
	reg [6:0] read_binary;
	wire [6:0] read_gray_next, read_binary_next;
	wire empty_val;
	
	// Gray Style 2 pointer (both gray code and binary code registers are present)
	always @(posedge clock_read or negedge read_reset_n)
		if (!read_reset_n) 
			{read_binary, read_pointer} <= 0;
		else 
			{read_binary, read_pointer} <= {read_binary_next, read_gray_next};
	
	assign read_binary_next = read_binary + (read_enable & ~empty);
	assign read_gray_next = (read_binary_next>>1) ^ read_binary_next;
	
	// Memory read-address pointer (binary is used to address memory)
	assign read_address = read_binary[5:0];
	
	// FIFO empty when the next read_pointer == synchronized wrt_ptr or on reset
	assign empty_val = (read_gray_next == sync_write_pointer);
	
	always @(posedge clock_read or negedge read_reset_n)
		if (!read_reset_n)
			empty <= 1'b1;
		else 
			empty <= empty_val;
	
endmodule