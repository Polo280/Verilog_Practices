module ClockDivider(
	input clk, rst, 
	output reg clk_div,
	output reg [25:0]num1
);

localparam target_count = 50_000_000;
reg [29:0] count;

SevenSegmentDisplay SevSegment(
	.number(num1)
);

always @(posedge clk or negedge rst)
begin
	if(!rst) begin
		count <= 30'b0;
		num1 <= 0;
	end
	else if(count == target_count -1) begin 
		num1 <= num1 + 1;
		count <= 30'b0; 
	end
	else begin
		num1 <= num1;
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