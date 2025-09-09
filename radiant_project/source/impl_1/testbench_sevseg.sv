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
	s = 4'b0000; #5; assert (seg == 7'b1000000); #20
	s = 4'b0001; #5; assert (seg == 7'b1111001); #20
	s = 4'b0010; #5; assert (seg == 7'b0100100); #20
	s = 4'b0011; #5; assert (seg == 7'b0110000); #20
	s = 4'b0100; #5; assert (seg == 7'b0011001); #20
	s = 4'b0101; #5; assert (seg == 7'b0010010); #20
	s = 4'b0110; #5; assert (seg == 7'b0000010); #20
	s = 4'b0111; #5; assert (seg == 7'b1111000); #20
	s = 4'b1000; #5; assert (seg == 7'b0000000); #20
	s = 4'b1001; #5; assert (seg == 7'b0011000); #20
	s = 4'b1010; #5; assert (seg == 7'b0001000); #20
	s = 4'b1011; #5; assert (seg == 7'b0000011); #20
	s = 4'b1100; #5; assert (seg == 7'b1000110); #20
	s = 4'b1101; #5; assert (seg == 7'b0100001); #20
	s = 4'b1110; #5; assert (seg == 7'b0000110); #20
	s = 4'b1111; #5; assert (seg == 7'b0001110); #20;
end

endmodule
		