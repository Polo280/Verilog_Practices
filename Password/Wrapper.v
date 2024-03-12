module Wrapper(
	input MAX10_CLK1_50,
	input [1:0] KEY,
	input [3:0] SW,
	output [9:0] LEDR,
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

Password PASSWORD(
	.clk(MAX10_CLK1_50),
	.rst(KEY[0]),
	.enable(KEY[1]),
	.out_password(LEDR[8:0]),
	.digit(SW),
	.clk_div(LEDR[9])
);

SevenSegmentDisplay Displays(
	.number(SW),
	.digit1(HEX0),
	.digit2(HEX1),
	.digit3(HEX2),
	.digit4(HEX3),
	.digit5(HEX4),
	.digit6(HEX5)
);

endmodule 