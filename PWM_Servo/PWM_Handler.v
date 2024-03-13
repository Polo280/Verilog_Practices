module PWM_Handler(
	input clk_div, rst, enable,
	input [7:0] degrees,    // Physical switches
	output reg pwm
);

reg[15:0] total_count = 2000;   // Count for reaching 20 ms using 100_000 hertz
reg[7:0] target_count= 0;      // Dynamic target count for high state (given by desired angle)
reg[15:0] counter = 0;

always @(negedge enable)
	begin
		// Limit upper value to 180
		if(degrees >= 180)
			target_count <= 200;  // Complete pulse of 2 ms
		else
			target_count <= 10 * degrees / 9; 
	end

// Handle generated signal counter (in servomotors is generally of 20ms)
always @(posedge clk_div)
	begin
		if(!rst) begin
			counter <= 0;
			pwm <= 0;
		end
		
		else begin
			if(counter <= target_count) begin
				pwm <= 1;
			end else if (counter == target_count) begin
				pwm <= 0;
			end else
				pwm <= 0;
			end
			
			if(counter < 2000)
				counter <= counter + 1;
			else
				counter <= 0;
	end 
endmodule 