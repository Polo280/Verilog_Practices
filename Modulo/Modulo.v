module Modulo(
	input [2:0] mod,
	input [6:0] number,
	output reg [6:0] result
);

always @(mod, number)
begin
	if(mod > 1)
		result <= number % mod;
	else
		result <= number;
end

endmodule 