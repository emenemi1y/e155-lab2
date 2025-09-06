module testbench_top();

/* 
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Testbench for the top module
*/

	logic clk;
	logic [3:0] s1, s2;
	logic [6:0] seg;
	logic [4:0] led;
	
top dut(s1, s2, seg, seg_power, led);

// generate clock
always 
	begin
		// period = 10 ticks
		clk = 1; #5;
		clk = 0; #5;
	end

initial
	begin 
		#20 s1 <= 4'b0000; s2 <= 4'b0000;
		#20 s1 <= 4'b0001; s2 <= 4'b0000;
	end

endmodule
		