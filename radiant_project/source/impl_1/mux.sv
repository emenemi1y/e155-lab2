module mux (input logic [3:0] s1, s2,
			input logic sel,
			output logic s);
			
/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Multiplexer that takes a one bit select
signal and returns one of two inputs.
*/
	
	assign s = sel ? s1 : s2;
	
endmodule