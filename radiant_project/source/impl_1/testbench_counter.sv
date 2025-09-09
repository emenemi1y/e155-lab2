module testbench_counter();

/* 
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Testbench for the counter module
*/

	logic clk, reset;
	logic sel;
	
counter dut(clk, reset, sel);

// generate clock
always 
	begin
		// period = 10 ticks
		clk = 1; #5;
		clk = 0; #5;
	end
	
initial begin
	reset = 0; #22
	reset = 1; 
end


endmodule
		