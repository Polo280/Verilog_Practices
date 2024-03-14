module Averager(
    input rst, clk,
    input [15:0] data_in,
    output reg [15:0] average_val
);

// Declare variable to store the sum of the values
reg[30:0] total_sum = 0;
reg[7:0] count = 0;

// Update sum until we get a group of 128 values 
always @(posedge clk) begin 
    if(!rst) begin
        count <= 0;
        total_sum <= 0;
        average_val <= 0;
    end else begin
        if(count < 127) begin // Count from 0 to 126
            count <= count + 1;
            total_sum <= total_sum + data_in;
        end else if(count == 127) begin // When reaching 127, calculate average
            average_val <= total_sum >> 7; // Calculate average
            count <= 0; // Reset count for next group of values
            total_sum <= data_in;
        end
    end
end 

endmodule