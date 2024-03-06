module ClockDiv_tb();
// Declarar las variables locales
reg clock, reset;
wire clk_d;

// Generar una instancia de la clase para pruebas
ClockDivider CLOCKDIV(
	.clk(clock),
	.rst(reset),
	.clk_div(clk_d)
);

initial 
	begin
		clock = 0;
		reset = 1;
		#5
		reset = 0;
		#10 
		reset = 1;
		$Stop; 
	end
always
	begin
		#5
		clock = ~clock;
	end 
	
endmodule 