// SET AS TOP LEVEL ENTITY
module Wrapper (
	input [1:0]KEY,
	output [8:0]LEDR
);

Pushbutton Deb(
	.button(KEY[0]),
	.led(LEDR[0])
);

endmodule 