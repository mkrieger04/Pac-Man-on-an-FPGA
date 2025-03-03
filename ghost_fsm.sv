module ghost_fsm(
	input logic clk,
	input logic reset,
	output logic [1:0] ghost_code
	);

typedef enum logic [1:0] {
	FIRST,
	SECOND
} animation_state;

logic [22:0] counter;
animation_state state;

always_ff @(posedge clk or posedge reset) begin
	if (reset) begin
	counter <= 0;
	state <= FIRST;
	ghost_code <= 2'b00;
	end else begin
		case (state)
			FIRST : begin
			 counter <= counter + 1;
			 ghost_code <= 2'b00;
			
             if (counter == 5_000_000) begin 
			 counter <= 0;
             state <= SECOND;
			 end
            end
            
			SECOND : begin
			 counter <= counter + 1;
			 ghost_code <= 2'b01;
			 
             if (counter == 5_000_000) begin 
			 counter <= 0;
             state <= FIRST;
			 end
            end
		endcase
	end
    end
endmodule