module Wrapper(
	input MAX10_CLK1_50,
	input [1:0]KEY, 
	output [9:0]LEDR
);

ClockDivider DUT(
	.clk(MAX10_CLK1_50),
	.rst(KEY[0]),
	.clk_div(LEDR[0])
);

endmodule 