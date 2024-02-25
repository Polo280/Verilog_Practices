module Test2(
	// Switches
	input clk, rst,
	input [3:0] digit,
	input enable, 
	output reg [1:0] out_password
);

// DEFINIR NUMEROS DE LA CONTRASENA
parameter pw_1 = 2, 
			 pw_2 = 0,
			 pw_3 = 3,
			 pw_4 = 4;
	
// DEFINIR ESTADOS
parameter IDLE = 0, 
	CHECK_1D = 1, 
	CHECK_2D = 2,
	CHECK_3D = 3,
	CHECK_4D = 4,
	CORRECT = 5;

// DEFINIR REGISTROS DE C_S Y N_S
reg [2:0]  current_state, next_state; // 3 bits porque son 6 estados

// PROCESO DE ACTUALIZACION DE ESTADO (esto es comun para todas las maquinas de estado)
always @(posedge clk or negedge rst)
begin
	if(!rst)
		current_state <= IDLE;
	else
		current_state <= next_state;
end


// PROCESO PARA ACTUALIZAR EL NEXT STATE 
always @(current_state, enable, digit)  // Se ejecuta cuando sea que haya un cambio en las entradas especificadas
begin
	case(current_state)
		IDLE:
		begin
			if(enable == 0)
				next_state = IDLE;
			else
				next_state = CHECK_1D;
		end
		CHECK_1D:
			begin
				if(enable == 1)
				begin
					if(digit == pw_1)
						next_state = CHECK_2D;
					else
						next_state = IDLE;
				end
				else
					next_state = CHECK_1D;
			end
		CHECK_2D:
			begin
				if(enable == 1)
				begin
					if(digit == pw_2)
						next_state = CHECK_3D;
					else
						next_state = IDLE;
				end
				else
					next_state = CHECK_2D;
			end
		CHECK_3D:
		begin
			if(enable == 1)
			begin
				if(digit == pw_3)
					next_state = CHECK_4D;
				else
					next_state = IDLE;
			end
			else
				next_state = CHECK_3D;
		end
		CHECK_4D:
			begin
				if(enable == 1)
				begin
					if(digit == pw_4)
						next_state = CORRECT;
					else
						next_state = IDLE;
				end
				else
					next_state = CHECK_4D;
			end
	default:
		next_state = IDLE;
	endcase
end


always

endmodule