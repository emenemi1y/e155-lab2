`timescale 1 ns / 1 ns

module testbench_top();

/* 
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Testbench for the top module
*/

	logic clock, reset;
	logic [3:0] s1, s2;
	logic [6:0] seg;
	logic [4:0] led;
	logic [1:0] seg_power;
	
top dut(clock, reset, s1, s2, seg, seg_power, led);

// generate clock
always 
	begin
		// period = 10 ticks
		clock = 1; #5;
		clock = 0; #5;
	end

initial
	begin
		reset = 1'b0; #22 reset = 1'b1; #53
		for (int i = 4'b0; i < 4'b1111; i++) begin
			for (int j = 4'b0; j < 4'b1111; j++) begin
				s1 <= i; s2 <= j; #100
				assert (led == i + j);
			end
		end
	end

endmodule
		