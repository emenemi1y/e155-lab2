module switch(
	input logic sel,
	output logic [1:0] anode_power
);
/* 
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Takes 1-bit input select and turns on the anode 
of the required seven-segment display (specified by
the two-bit output anode_power). anode_power[0] 
corresponds to the first digit and anode_power[1] 
corresponds to the second.
*/

	assign anode_power[0] = sel;
	assign anode_power[1] = ~sel;
	
endmodule