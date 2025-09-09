module top(
	input logic reset,
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
	
	
	
	// INSTANTIATE MODULES
	logic [3:0] s;
	mux mux1(s1, s2, sel, s);
	sevseg sevseg_logic(s, seg);
	counter counter1(clk, reset, sel);
	
	// APPLY POWER TO CORRECT SEVEN-SEGMENT DISPLAY
	assign seg_power[0] = sel;
	assign seg_power[1] = ~sel;
	
	// ADDITION
	assign led = s1 + s2;
	
endmodule
