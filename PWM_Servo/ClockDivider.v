module ClockDivider #(parameter HERTZ = 200_000)( // Resolution of 200 / 180°
	input clk, rst, 
	output reg clk_div
);

// Divide internal oscillator frequency by the desired hertz to get the target_count
localparam target_count = 50_000_000 / HERTZ;
reg [29:0] count;

always @(posedge clk or negedge rst)
begin
	if(!rst) begin      // If reset button is pressed
		count <= 30'b0;
	end
	else if(count == target_count) begin  // If counter reaches target value 
		count <= 30'b0; 
	end
	else begin
		count <= count + 1;
	end
end

always @(posedge clk or negedge rst)
begin
	if(!rst) begin
		clk_div <= 1'b0;
	end
	else if(count == target_count - 1)
		begin
			clk_div <= ~clk_div;
		end
	else begin
		clk_div <= clk_div;   // Refrescar los registros para no perder la informacion
	end
end

endmodule 