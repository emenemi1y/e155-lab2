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
	
top dut(reset, s1, s2, seg, seg_power, led);

// generate clock
always 
	begin
		// period = 10 ticks
		clock = 1; #5;
		clock = 0; #5;
	end

initial
	begin
		reset = 1; #40 reset = 0; #40
		s1 <= 4'b0000; s2 <= 4'b0001; #20
		s1 <= 4'b0101; s2 <= 4'b1010; #20
		s1 <= 4'b1111; s2 <= 4'b1111; #20
		s1 <= 4'b1000; s2 <= 4'b0010; #20
		s1 <= 4'b1100; s2 <= 4'b0100; 
	end

endmodule
		