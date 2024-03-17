
module two_boards_DE10_Lite_wr(
	input       MAX10_CLK1_50, // clock
	input [9:0] SW,   // Input for transmiter   
	input [1:0] KEY, // RST
	
	// ARDUINO_IO[0] --> send, ARDUINO_IO[1] --> receive
	inout [9:0] ARDUINO_IO, // tx_transmiter_out
	
	//LED indicators
	output   [9:0]   LEDR,
	
	//Decoders
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5

);


// Connect modules without using two boards

reg [7:0] data_transmit;
wire [7:0] received_data; // check what BOARD2 received


// Map received data to 7 segment displays
reg [3:0] RECEIVER_units;
reg [3:0] RECEIVER_tens;
reg [2:0] RECEIVER_hundreds;

always @(received_data) begin
	RECEIVER_units = received_data % 10;
	RECEIVER_tens = (received_data / 10) % 10;
	RECEIVER_hundreds = (received_data / 100) % 100;
end

segmentos_7 RECEIVER_DISPLAY1(
	.data_segmentos_in(RECEIVER_units),
	.data_segmentos_out(HEX0)
);

segmentos_7 RECEIVER_DISPLAY2(
	.data_segmentos_in(RECEIVER_tens),
	.data_segmentos_out(HEX1)
);

segmentos_7 RECEIVER_DISPLAY3(
	.data_segmentos_in(RECEIVER_hundreds),
	.data_segmentos_out(HEX2)
);


// Map sent data to 7 segment displays
reg [3:0] TRANSMITER_units;
reg [3:0] TRANSMITER_tens;
reg [2:0] TRANSMITER_hundreds;

always @(SW[7:0]) begin
	TRANSMITER_units = SW[7:0] % 10;
	TRANSMITER_tens = (SW[7:0] / 10) % 10;
	TRANSMITER_hundreds = (SW[7:0] / 100) % 100;
end

segmentos_7 TRANSMITER_DISPLAY1(
	.data_segmentos_in(TRANSMITER_units),
	.data_segmentos_out(HEX3)
);

segmentos_7 TRANSMITER_DISPLAY2(
	.data_segmentos_in(TRANSMITER_tens),
	.data_segmentos_out(HEX4)
);

segmentos_7 TRANSMITER_DISPLAY3(
	.data_segmentos_in(TRANSMITER_hundreds),
	.data_segmentos_out(HEX5)
);


// Only select data from switches when botton is pressed, else send 8b'0
always @(posedge MAX10_CLK1_50)
begin
	if(SW[9])
		data_transmit = SW[7:0];
	else
		data_transmit = 8'b0;
end


// BOARD1 to act as transmiter
TOP BOARD1(
    	.Clk(MAX10_CLK1_50)      ,
    	.Rst_n(KEY[0])    	    ,   
   	.Rx()                    ,    
    	.Tx(ARDUINO_IO[0])   ,
		.RxData() 		          ,
		.TxData(data_transmit)
);


// BOARD2 to act as receiver
TOP BOARD2(
    	.Clk(MAX10_CLK1_50)      ,
    	.Rst_n(KEY[0])    	    ,   
   	.Rx(ARDUINO_IO[1])   ,    
    	.Tx()                    ,
		.RxData(received_data)   ,
		.TxData()
);


endmodule
