module SevenSegmentDisplay(
	input wire [25:0] number,
	output wire [6:0] digit1,
	output wire [6:0] digit2,
	output wire [6:0] digit3,
	output wire [6:0] digit4,
	output wire [6:0] digit5,
	output wire [6:0] digit6
);

wire[3:0] n1, n2, n3, n4, n5, n6;

DisplayNumber Display1(
	.digit(n1),
	.DisplayedNumber(digit1)
);
DisplayNumber Display2(
	.digit(n2),
	.DisplayedNumber(digit2)
);

DisplayNumber Display3(
	.digit(n3),
	.DisplayedNumber(digit3)
);

DisplayNumber Display4(
	.digit(n4),
	.DisplayedNumber(digit4)
);

DisplayNumber Display5(
	.digit(n5),
	.DisplayedNumber(digit5)
);

DisplayNumber Display6(
	.digit(n6),
	.DisplayedNumber(digit6)
);

assign n1 = number % 10;

assign n2 = (number / 10) % 10;

assign n3 = ((number / 100) % 10);

assign n4 = ((number / 1000) % 10);

assign n5 = ((number / 10000) % 10);

assign n6 = ((number / 100000) % 10);

endmodule
