module DisplayNumber(
	input [3:0] digit,
	output reg [6:0] DisplayedNumber
);

always @(digit)
	begin
		case(digit)
			4'b0000: DisplayedNumber = 7'b1000000;
			4'b0001: DisplayedNumber = 7'h79;
			4'b0010: DisplayedNumber = 7'h24;
			4'b0011: DisplayedNumber = 7'h30;
			4'b0100: DisplayedNumber = 7'h19;
			4'b0101: DisplayedNumber = 7'h12;
			4'b0110: DisplayedNumber = 7'h02;	
			4'b0111: DisplayedNumber = 7'h78;
			4'b1000: DisplayedNumber = 7'h00;
			4'b1001: DisplayedNumber = 7'h18;
			default: DisplayedNumber = 7'b0111111;
		endcase
	end
endmodule 