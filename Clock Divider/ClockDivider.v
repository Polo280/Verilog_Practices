module ClockDivider(
	input clk, rst, 
	output reg clk_div
);

localparam target_count = 50_000_000;
reg [29:0] count;

always @(posedge clk or negedge rst)
begin
	if(!rst)
		count <= 50'b0;
	else if(count == target_count -1)
		count <= 50'b0;
	else
		count <= count + 1;
end

always @(posedge clk or negedge rst)
begin
	if(!rst)
		clk_div <= 1'b0;
	else if(count == target_count - 1)
		clk_div <= ~clk_div;
	else
		clk_div <= clk_div;   // Refrescar los registros para no perder la informacion
end

endmodule 