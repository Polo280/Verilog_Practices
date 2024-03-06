module Pushbutton(
	input button,
	output reg led
);

always @(button)
	begin
		if(button)
			led <= 1;
		else
			led <= 0;
	end
endmodule 