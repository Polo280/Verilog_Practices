module ALU(
	input clk,
	input [3:0] instruction,
	input signed [31:0] num1, num2,
	output reg signed [31:0] result,
	output reg [3:0] flags    // N, Z, C, V
);

// Auxiliary buses
wire[31:0] aux, aux0, aux1, aux2, aux4;

// Auxiliary variable for storing previous carry flag
reg [3:0] prev_flags;

// 32 bit adder module
reg adder_cin;
wire adder_cout;
Adder NormalAdder(
	.c_in(adder_cin),
	.num1(num1),
	.num2(num2),
	.sum(aux),
	.c_out(adder_cout) 
);

initial begin
	adder_cin <= 0;
end

// 32 bit adder with carry
reg cadder_cin;
wire cadder_cout;
Adder CarryAdder(
	.c_in(cadder_cin),
	.num1(num1),
	.num2(num2),
	.sum(aux0),
	.c_out(cadder_cout) 
);

initial begin
	cadder_cin <= 0;
end

// Module for bitwise not
BitwiseNot BitNotModule (
	.in(num1),
	.out(aux2)
);

// Module for subtractor with carry
wire sub_c_out;
Subtractor SubCarry (
	.num1(num1),
	.num2(num2),
	.result(aux4),
	.c_out(sub_c_out)
);


// Instructions of ALU
parameter ADCS = 6,
			 ADD = 7,
		    MULS = 8,
			 MVNS = 9,
			 NOP = 10,
			 ORRS = 11,
			 SBCS = 12,
			 SUB = 13,
			 TST = 14;
			 
// Flag index
parameter NEGATIVE = 0,
			 ZERO = 1,
			 CARRY = 2,
			 OVERFLOW = 3;
			 
// Initial values
initial begin 
	flags <= 0;
	result <= 0;
end

// For updating  carry flag with last values
always @(negedge clk)
begin 
	prev_flags <= flags;
	cadder_cin <= flags[CARRY];
end 

// Make a synchronous module 
always @(posedge clk)
begin
	case (instruction)
		///////////////// ADCS //////////////////
		ADCS:
			begin
				result <= aux0;
				
				// Negative flag
				flags[NEGATIVE] <= aux0[31];
				// Carry flag 
				flags[CARRY] <= cadder_cout;
				// Zero flag
				flags[ZERO] <= (aux0 == 0);
			end 
		////////////////// ADD //////////////////
		ADD:
			begin
				adder_cin <= 0;
				result <= aux;
				
				// Negative flag
				flags[NEGATIVE] <= aux[31];
				// Carry flag 
				flags[CARRY] <= adder_cout;
				// Zero flag
				flags[ZERO] <= (aux == 0);
			end
			
		////////////// Bitwise NOT //////////////
		MVNS:
			begin
				result <= aux2;
				if(aux2[31] == 1) begin // If number is negative
					flags[NEGATIVE] <= 1;
				end else if (aux2 == 0) begin
					flags[ZERO] <= 1;
				end
			end
			
		/////////// Subtraction carry ///////////
		SBCS:
			begin
				result <= aux4;
				
				// Check for carry
				if(sub_c_out == 1)   // Check if this should be inverted
					flags[CARRY] <= 1;
				// Check for sign
				if(aux4[31] == 1)
					flags[NEGATIVE] <= 1;
				// Check for zerO
				if(aux4 == 0)
					flags[ZERO] <= 1;
			end
			
		///////////// Subtraction /////////////
		SUB:
			begin
				result <= aux4;  // Same as sbcs but dont update carry flag
				
				// Check for sign
				if(aux4[31] == 1)
					flags[NEGATIVE] <= 1;
				// Check for zerO
				if(aux4 == 0)
					flags[ZERO] <= 1;
			end
		//////////////// Default ////////////////
		default:
			begin
				result <= 0;
				flags <= 0;
			end
	endcase
end

endmodule
