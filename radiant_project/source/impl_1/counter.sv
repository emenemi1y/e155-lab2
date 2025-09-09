module counter(
	input logic clk, reset,
	output logic sel
);

/* 
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Creates a divider for an input clock to obtain a switching frequency 
that is slower than the original clock by a factor of 10000.
*/

	logic [24:0] count;
	logic [24:0] NUM_CYCLES;
	assign NUM_CYCLES = 24'd9999;

	// counter
	always_ff @(posedge clk) begin
		if (reset == 0) begin
			count <= 0;
			sel <= 0;
		end
		else begin
			if (count == NUM_CYCLES) begin
				count <= 0;
				sel <= ~sel;
			end
			else count <= count + 1;
		end
	end

endmodule