module BitwiseNot(
	input wire [31:0] in,
	output wire [31:0] out 
);

// Update in combinational logic 
assign out = ~in;

endmodule 

