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
	s1 <= 4'b0000; s2 <= 4'b0001; sel <= 1'b0; #5;
	assert (s == 4'b0001); #5;
	sel <= 1'b1; #5;
	assert (s == 4'b0000) #5;
	s1 <= 4'b0101; s2 <= 4'b1010; sel <= 1'b0; #5;
	assert (s == 4'b1010); #5;
	sel <= 1'b1; #5;
	assert (s == 4'b0101); #5;
	s1 <= 4'b1111; s2 <= 4'b1000; sel <= 1'b0; #5;
	assert (s == 4'b1000); #5;
	sel <= 1'b1; #5;
	assert (s == 4'b1111); 
end


endmodule
		