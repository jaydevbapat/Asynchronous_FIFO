module Memory_fifo(
			output 	[15:0] 	read_data,
			input 	[15:0] 	write_data,
			input 	[6:0] 	write_address, read_address,
			input 				write_enable, full, clock_write);

	
	
	// memory with 16 bit data and 127s locations(depth)
	reg [15:0] mem [0:127];
	
	assign read_data = mem [read_address];
	
	always @(posedge clock_write)
	begin
		if (write_enable & (~full)) 
			mem [write_address] <= write_data;
	end
	
endmodule
