module PWM_Generator(
	input clk, rst, enable,
	input[7:0] switches,
	output pwm_signal
);

// Intermediate wire to carry the signal to next module
wire clk_div;

ClockDivider Clock_div(
	.clk(clk),
	.rst(rst),
	.clk_div(clk_div)
);


PWM_Handler PWM_Handle(
	.clk_div(clk_div),
	.degrees(switches),
	.pwm(pwm_signal),
	.rst(rst),
	.enable(enable)
);

endmodule 