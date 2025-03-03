module pacman_fsm(
	input logic clk,
	input logic reset,
	input logic [9:0] motion_x,
	input logic [9:0] motion_y,
	input logic won, 
	output logic [3:0] pac_code
	);

typedef enum logic [3:0] {
CIRCLE,
UP_OPEN,
UP_CLOSE,
DOWN_OPEN,
DOWN_CLOSE,
LEFT_OPEN,
LEFT_CLOSE,
RIGHT_OPEN,
RIGHT_CLOSE
} animation_state;

logic [22:0] counter;
animation_state state;

always_ff @(posedge clk or posedge reset) begin	
	if (reset) begin
	counter <= 0;
	state <= CIRCLE;
	pac_code <= 5'b0;
	end else begin
		case (state)
		CIRCLE : begin
		counter <= counter + 1;
		pac_code <= 4'b0000; 
		if (counter == 5_000_000) begin
		counter <= 0;
	
		if (won == 1'b1)
			state <= CIRCLE;

		else if (motion_x == -10'd1)
			state <= LEFT_OPEN;

		else if (motion_x == 10'd1)
			state <= RIGHT_OPEN;
		
		else if (motion_y == -10'd1)
			state <= UP_OPEN;

		else if (motion_y == 10'd1)
			state <= DOWN_OPEN;
		
		else
			state <= CIRCLE;
		end
		end
		UP_OPEN : begin
		counter <= counter + 1;
		pac_code <= 4'b0010; 
		if (counter == 5_000_000) begin
		counter <= 0;
	
		if (won == 1'b1)
			state <= CIRCLE;

		else if (motion_x == -10'd1)
			state <= LEFT_CLOSE;

		else if (motion_x == 10'd1)
			state <= RIGHT_CLOSE;
		
		else if (motion_y == -10'd1)
			state <= UP_CLOSE;

		else if (motion_y == 10'd1)
			state <= DOWN_CLOSE;
		
		else
			state <= CIRCLE;
		end
		end
		UP_CLOSE : begin
		counter <= counter + 1;
		pac_code <= 4'b0001; 
		if (counter == 5_000_000) begin
		counter <= 0;
	
		if (won == 1'b1)
			state <= CIRCLE;

		else if (motion_x == -10'd1)
			state <= LEFT_CLOSE;

		else if (motion_x == 10'd1)
			state <= RIGHT_OPEN;
		
		else if (motion_y == -10'd1)
			state <= UP_OPEN;

		else if (motion_y == 10'd1)
			state <= DOWN_OPEN;
		
		else
			state <= CIRCLE;
		end
		end
		DOWN_OPEN : begin
		counter <= counter + 1;
		pac_code <= 4'b0110; 
		if (counter == 5_000_000) begin
		counter <= 0;
	
		if (won == 1'b1)
			state <= CIRCLE;

		else if (motion_x == -10'd1)
			state <= LEFT_CLOSE;

		else if (motion_x == 10'd1)
			state <= RIGHT_CLOSE;
		
		else if (motion_y == -10'd1)
			state <= UP_CLOSE;

		else if (motion_y == 10'd1)
			state <= DOWN_CLOSE;
		
		else
			state <= CIRCLE;
		end
		end
		DOWN_CLOSE : begin
		counter <= counter + 1;
		pac_code <= 4'b0101; 
		if (counter == 5_000_000) begin
		counter <= 0;
	
		if (won == 1'b1)
			state <= CIRCLE;

		else if (motion_x == -10'd1)
			state <= LEFT_OPEN;

		else if (motion_x == 10'd1)
			state <= RIGHT_OPEN;
		
		else if (motion_y == -10'd1)
			state <= UP_OPEN;

		else if (motion_y == 10'd1)
			state <= DOWN_OPEN;
		
		else
			state <= CIRCLE;
		end
		end
		LEFT_OPEN : begin
		counter <= counter + 1;
		pac_code <= 4'b1000; 
		if (counter == 5_000_000) begin
		counter <= 0;
	
		if (won == 1'b1)
			state <= CIRCLE;

		else if (motion_x == -10'd1)
			state <= LEFT_CLOSE;

		else if (motion_x == 10'd1)
			state <= RIGHT_CLOSE;
		
		else if (motion_y == -10'd1)
			state <= UP_CLOSE;

		else if (motion_y == 10'd1)
			state <= DOWN_CLOSE;
		
		else
			state <= CIRCLE;
		end
		end
		LEFT_CLOSE : begin
		counter <= counter + 1;
		pac_code <= 4'b0111;
		if (counter == 5_000_000) begin
		counter <= 0;
	
		if (won == 1'b1)
			state <= CIRCLE;

		else if (motion_x == -10'd1)
			state <= LEFT_OPEN;

		else if (motion_x == 10'd1)
			state <= RIGHT_OPEN;
		
		else if (motion_y == -10'd1)
			state <= UP_OPEN;

		else if (motion_y == 10'd1)
			state <= DOWN_OPEN;
		
		else
			state <= CIRCLE;
		end
		end
		RIGHT_OPEN : begin
		counter <= counter + 1;
		pac_code <= 4'b0100;
		if (counter == 5_000_000) begin
		counter <= 0;
	
		if (won == 1'b1)
			state <= CIRCLE;

		else if (motion_x == -10'd1)
			state <= LEFT_CLOSE;

		else if (motion_x == 10'd1)
			state <= RIGHT_CLOSE;
		
		else if (motion_y == -10'd1)
			state <= UP_CLOSE;

		else if (motion_y == 10'd1)
			state <= DOWN_CLOSE;
		
		else
			state <= CIRCLE;
		end
		end
		RIGHT_CLOSE : begin
		counter <= counter + 1;
		pac_code <= 4'b0011;
		if (counter == 5_000_000) begin
		counter <= 0;
	
		if (won == 1'b1)
			state <= CIRCLE;

		else if (motion_x == -10'd1)
			state <= LEFT_OPEN;

		else if (motion_x == 10'd1)
			state <= RIGHT_OPEN;
		
		else if (motion_y == -10'd1)
			state <= UP_OPEN;

		else if (motion_y == 10'd1)
			state <= DOWN_OPEN;
		
		else
			state <= CIRCLE;

		end
		end 
		endcase
	end
end
endmodule