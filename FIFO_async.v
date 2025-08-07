module FIFO_async (output [15:0] read_data,
			  output full,
			  output empty,
			  input [15:0] write_data,
			  input write_enable, clock_write, write_reset_n,
			  input read_enable, clock_read, read_reset_n);
	
	wire [5:0] write_address, read_address;
	wire [6:0] write_pointer, read_pointer, sync_read_pointer, sync_write_pointer;

	Sync_read_2_write srw (sync_read_pointer, read_pointer, clock_write, write_reset_n);

	Sync_write_to_read swr (sync_write_pointer, write_pointer, clock_read, read_reset_n);

	Memory_fifo fm (read_data, write_data, write_address, read_address, write_enable, full, clock_write);

	read_pointer_empty re (empty, read_address, read_pointer, sync_write_pointer, read_enable, clock_read, read_reset_n);

	write_pointer_full wf (full, write_address, write_pointer, sync_read_pointer, write_enable, clock_write, write_reset_n);

endmodule