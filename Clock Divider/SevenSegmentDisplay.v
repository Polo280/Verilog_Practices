module SevenSegmentDisplay(
	input wire [25:0] number,
	output reg [6:0] digit1,
	output reg [6:0] digit2,
	output reg [6:0] digit3,
	output reg [6:0] digit4,
	output reg [6:0] digit5,
	output reg [6:0] digit6
);

reg[3:0] digit_aux;

function [7:0] DisplayedNumber;
	input [3:0] digit;
	begin
		case(digit)
			4'b0000:
				DisplayedNumber = 7'b1000000;
			4'b0001:
				DisplayedNumber = 7'h79;
			4'b0010:
				DisplayedNumber = 7'h24;
			4'b0011:
				DisplayedNumber = 7'h30;
			4'b0100:
				DisplayedNumber = 7'h19;
			4'b0101:
				DisplayedNumber = 7'h12;
			4'b0110:
				DisplayedNumber = 7'h02;	
			4'b0111:
				DisplayedNumber = 7'h78;
			4'b1000:
				DisplayedNumber = 7'h00;
			4'b1001:
				DisplayedNumber = 7'h18;
			default:
				DisplayedNumber = 7'b0111111;
		endcase
	end
endfunction


always @(*)
	begin 
		// Get the value for each digit
		digit_aux <= number % 10;
		digit1 <= DisplayedNumber(digit_aux);
	
		digit_aux <= (number / 10) % 10;
		digit2 <= DisplayedNumber(digit_aux);

		digit_aux <= (number / 100) % 10;
		digit3 <= DisplayedNumber(digit_aux);
	
		digit_aux <= (number / 1000) % 10;
		digit4 <= DisplayedNumber(digit_aux);

		digit_aux <= (number / 10000) % 10;
		digit5 <= DisplayedNumber(digit_aux);

		digit_aux <= (number / 100000) % 10;
		digit6 <= DisplayedNumber(digit_aux);
	end
endmodule
