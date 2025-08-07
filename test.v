`timescale 1ns/1ns

module testbench;

	reg [15:0] write_data;
	reg write_enable, clock_write, write_reset_n;
	reg read_enable, clock_read, read_reset_n;
	wire [15:0] read_data;
	wire full, empty;
	
	integer i;
	
	FIFO_async fifo (read_data,
				full,
				empty,
			        write_data,
			   	write_enable,
				clock_write,
				write_reset_n,
			   	read_enable,
				clock_read,
				read_reset_n);
	
	always
	begin
		clock_read = ~clock_read; 
		#50;
	end
	
	always
	begin
		clock_write = ~clock_write;
		#10;
	end
	
	initial
	begin
		clock_read = 0;
		clock_write = 0;
		read_reset_n = 0;
		write_reset_n = 0;
		write_enable = 0;
		read_enable = 0;
		#120;
		
		read_reset_n = 1;
		write_reset_n = 1;
		#25;
		
		write_data = 420;
		write_enable = 1;
		read_enable = 1;
		#20;
		for (i=1; i<50; i=i+1)
		begin
			write_data = i;
			#20;
		end
		write_enable = 0;
		
		#5000;
		
		write_data = 619;
		write_enable = 1;
		#20;
		for (i=1; i<50; i=i+1)
		begin
			write_data = 2*i + 3*i*i + 5;
			#20;
		end
		write_enable = 0;
		
		#5000;
		$stop;
	end
endmodule