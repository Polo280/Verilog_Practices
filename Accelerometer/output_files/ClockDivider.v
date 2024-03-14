module ClockDivider(
    input clk,
    input rst,    // Added reset signal
    output reg clk_div
);

localparam target_count = 50_000_000 / 5000;
reg [29:0] count = 0;  // Explicit initialization for simulation

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        count <= 0;
        clk_div <= 0;  // Resetting state
    end
    else if (count == target_count - 1) begin  // Adjusted for off-by-one error
        count <= 0;
        clk_div <= ~clk_div;  // Toggle clk_div
    end else begin
        count <= count + 1;
    end
    // Removed "clk_div <= clk_div;" as it is unnecessary outside of reset and toggle conditions
end

endmodule