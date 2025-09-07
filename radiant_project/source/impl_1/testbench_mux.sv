module testbench_mux();

/* 
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Testbench for the mux module
*/

	logic clk;
	logic [3:0] s1, s2;
	logic sel;
	logic [3:0] s;
	
mux dut(s1, s2, sel, s);

// generate clock
always 
	begin
		// period = 10 ticks
		clk = 1; #5;
		clk = 0; #5;
	end
	
initial begin
	s1 <= 0000; s2 <= 0001; sel <= 0; #5
	sel <= 1; #5
	s1 <= 0101; s2 <= 1010; sel <= 0; #5
	sel <= 1; #5
	s1 <= 1111; s2 <= 1000; sel <= 0; #5
	sel <= 1;
end


endmodule
		