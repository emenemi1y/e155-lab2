module testbench_sevseg();

/* 
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Testbench for the sevseg module
*/

	logic clk;
	logic [3:0] s;
	logic [6:0] seg;
	
sevseg dut(s, seg);

// generate clock
always 
	begin
		// period = 10 ticks
		clk = 1; #5;
		clk = 0; #5;
	end

initial begin 
	s = 0000; #20
	s = 0001; #20
	s = 0010; #20
	s = 0011; #20
	s = 0100; #20
	s = 0101; #20
	s = 0110; #20
	s = 0111; #20
	s = 1000; #20
	s = 1001; #20
	s = 1010; #20
	s = 1011; #20
	s = 1100; #20
	s = 1101; #20
	s = 1110; #20
	s = 1111;
end

endmodule
		