module Wrapper(
	input MAX10_CLK1_50,
	input [1:0] KEY,
	input [7:0] SW,
	output [1:0]ARDUINO_IO,
	output [9:0] LEDR,
	output [6:0] HEX0, HEX1, HEX2
);

// Turn on leds where switches are enabled
assign LEDR[7:0] = SW;
assign LEDR[9] = KEY[1];

PWM_Generator PWM1(
	.clk(MAX10_CLK1_50),
	.switches(SW),
	.pwm_signal(ARDUINO_IO[0]),
	.rst(KEY[0]),
	.enable(KEY[1])
);

SevenSegmentDisplay Displays(
	.number(SW),
	.digit1(HEX0),
	.digit2(HEX1),
	.digit3(HEX2)
);

endmodule 