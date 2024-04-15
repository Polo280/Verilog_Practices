`timescale 1ns / 1ns

module ALU_tb();

reg clock;
reg[3:0] instruction;
reg [31:0] num1, num2;
wire [31:0] result;
wire [3:0] flags;

ALU ALU_Mod(
	.clk(clock),
	.instruction(instruction),
	.num1(num1),
	.num2(num2),
	.result(result),
	.flags(flags)
);

initial 
	begin
		clock = 0;
		instruction = 0;
		num1 = 0;
		num2 = 0;
		#2
		instruction = 9;     // Bitwise not test
		num1 = 4294967200;
		#2 
		instruction = 12;    // Subtract test 
		num1 = 4294967200;
		num2 = 4294967195;
		#2 
		instruction = 7;   	// Adder test
		num1 = 4294967200;
		num2 = 4294967200;
		#2
		instruction = 6;
		num1 = 7;
		num2 = 2;
		#2 
		instruction = 0;
		$Stop;
	end

always
	begin
		#1
		clock = ~clock;
	end

endmodule
