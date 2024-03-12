module Wrapper(
	input [1:0] KEY,
	input [9:0] SW,
	output[9:0] LEDR,
	output[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

// Wire to get the result of modulo 
wire [6:0] num;

assign LEDR = SW;

Modulo DUT(
	.mod(SW[2:0]),
	.number(SW[9:3]),
	.result(num)
);

SevenSegmentDisplay SevSegment(
	.number(num),
	.digit1(HEX0),
	.digit2(HEX1),
	.digit3(HEX2),
	.digit4(HEX3),
	.digit5(HEX4),
	.digit6(HEX5)
);

endmodule 