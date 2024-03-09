module ClockDivider(
	input clk, rst, 
	output reg clk_div,
	output reg [25:0]num,
	output wire [6:0] d1, d2, d3, d4, d5, d6
);

localparam target_count = 50_000_000;
reg [29:0] count;

SevenSegmentDisplay SevSegment(
	.number(num),
	.digit1(d1),
	.digit2(d2),
	.digit3(d3),
	.digit4(d4),
	.digit5(d5),
	.digit6(d6)
);

always @(posedge clk or negedge rst)
begin
	if(!rst) begin
		count <= 30'b0;
		num <= 0;
	end
	else if(count == target_count -1) begin 
		num <= num + 1;
		count <= 30'b0; 
	end
	else begin
		num <= num;
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