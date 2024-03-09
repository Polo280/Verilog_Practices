module Wrapper(
	input MAX10_CLK1_50,
	input [1:0]KEY, 
	output [9:0]LEDR,
	output [6:0]HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

ClockDivider DUT(
	.clk(MAX10_CLK1_50),
	.rst(KEY[0]),
	.clk_div(LEDR[0]),
	.d1(HEX0),
	.d2(HEX1),
	.d3(HEX2),
	.d4(HEX3),
	.d5(HEX4),
	.d6(HEX5)
);

endmodule 