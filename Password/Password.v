module Password(
	// Switches
	input clk, rst,
	input [3:0] digit,
	input enable, 
	output reg [8:0] out_password,
	output reg clk_div
);

// DEFINIR NUMEROS DE LA CONTRASENA
parameter pw_1 = 2, 
			 pw_2 = 0,
			 pw_3 = 1,
			 pw_4 = 4;
	
// DEFINIR ESTADOS
parameter IDLE = 0, 
	CHECK_1D = 1, 
	CHECK_2D = 2,
	CHECK_3D = 3,
	CHECK_4D = 4,
	CORRECT = 5,
	INCORRECT = 6;

// DEFINIR REGISTROS DE C_S Y N_S
reg [2:0]  current_state = IDLE;
reg [2:0] next_state = IDLE; // 3 bits porque son 6 estados

// Para el clock divider 
localparam target_count = 50_000_000;
reg [29:0] count = 0;

// PROCESO DE ACTUALIZACION DE ESTADO (esto es comun para todas las maquinas de estado)
always @(posedge clk or negedge rst)
begin
	// Reset button sets everything to 0
	if(!rst) begin
		current_state <= IDLE;
		count <= 0;
		clk_div <= 0;
	end
	
	// Update state variable and clock ouput every second
	else if(count == target_count- 1) begin
		current_state <= next_state;
		count <= 0;
		clk_div <= ~clk_div;
	end else begin
		count <= count + 1;
	end
end


// PROCESO PARA ACTUALIZAR EL NEXT STATE 
always @(*)  // Se ejecuta cuando sea que haya un cambio en las entradas especificadas
begin
	case(current_state)
		IDLE:
		begin
			out_password <= 7'b0000001;
			if(enable == 1)
				next_state <= IDLE;
			else
				next_state <= CHECK_1D;
		end
		CHECK_1D:
			begin
				out_password <= 7'b0000010;
				if(enable == 0)
				begin
					if(digit == pw_1)
						next_state <= CHECK_2D;
					else
						next_state <= IDLE;
				end
				else
					next_state <= CHECK_1D;
			end
		CHECK_2D:
			begin
			out_password <= 7'b0000100;
				if(enable == 0)
				begin
					if(digit == pw_2)
						next_state <= CHECK_3D;
					else
						next_state <= IDLE;
				end
				else
					next_state <= CHECK_2D;
			end
		CHECK_3D:
			begin
			out_password <= 7'b0001000;
			if(enable == 0)
			begin
				if(digit == pw_3)
					next_state <= CHECK_4D;
				else
					next_state <= IDLE;
			end
			else
				next_state <= CHECK_3D;
		end
		CHECK_4D:
			begin
				out_password <= 7'b0010000;
				if(enable == 0)
				begin
					if(digit == pw_4)
						next_state <= CORRECT;
					else
						next_state <= INCORRECT;
				end
				else
					next_state <= CHECK_4D;
			end
		CORRECT:
			begin
				out_password <= 9'b100000000;
				if(!enable)
					next_state <= IDLE;
				else
					next_state <= CORRECT;
			end
		INCORRECT:
			begin
				out_password <= 9'b010000000;
				if(!enable)
					next_state <= IDLE;
				else
					next_state <= INCORRECT;
			end
	default:
		next_state <= IDLE;
	endcase
end

endmodule 