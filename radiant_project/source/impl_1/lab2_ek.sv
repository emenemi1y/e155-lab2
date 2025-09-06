module top(
	input logic [3:0] s1, s2,
	output logic [6:0] seg,
	output logic [1:0] seg_power,
	output logic [4:0] led
);

/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Top-level module for E155 Lab 2.
Instantiates high-speed oscillator for use 
in time-multiplexing. Instantiates modules for 
7-segment and LED logic and time-multiplexing.
*/
	
	// instantiate clock
	logic clk;
	logic sel;
	HSOSC #(.CLKHF_DIV(2'b01))
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
		
	// CLOCK DIVIDER TO OBTAIN DESIRED SWITCHING FREQUENCY OF ____ Hz
	// just copying from lab 1 so currently at 2.4 hz, need to change (too slow probably lol)
	logic [24:0] counter;
	logic [24:0] NUM_CYCLES;
	assign NUM_CYCLES = 24'd999_999;
	
	// counter
	always_ff @(posedge clk) begin
		if (counter == NUM_CYCLES) begin
			counter <= 0;
			sel <= ~sel;
		end
		else counter <= counter + 1;
	end
	
	// INSTANTIATE MODULES
	mux mux1(s1, s2, sel, s);
	sevseg sevseg_logic(s, seg);
	
	// APPLY POWER TO CORRECT SEVEN-SEGMENT DISPLAY
	assign seg_power[0] = sel;
	assign seg_power[1] = ~sel;
	
	// ADDITION
	assign led = s1 + s2;
	
endmodule
