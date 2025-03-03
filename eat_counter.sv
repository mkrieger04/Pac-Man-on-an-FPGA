module eat_counter(
    input logic clk,
    input logic reset,
    input logic en,
    output logic eat_time,
    output logic white
);

typedef enum logic [1:0] {
    IDLE,
    RUNNING,
    DONE
} timer_state;

logic [31:0] counter;
timer_state state;

always_ff @(posedge clk or posedge reset) begin
    if (reset) 
    begin
        counter <= 0;
        state <= IDLE;
        eat_time <= 0;
        white <= 0;
    end 
    
    else begin
        case (state)
            IDLE: 
            begin
                if (en) 
                begin
                    state <= RUNNING;
                    counter <= 0;
                end
            end
            
            RUNNING: 
            begin
                counter <= counter + 1;
                eat_time <= 1;
                
                if (counter <= 500_000_000 && counter >= 475_000_000)
                    white <= 1'b1;
                else if (counter <= 450_000_000 && counter >= 425_000_000)
                    white <= 1'b1;
                else if (counter <= 400_000_000 && counter >= 375_000_000)
                    white <= 1'b1;
                else if (counter <= 350_000_000 && counter >= 325_000_000)
                    white <= 1'b1;
                else
                    white <= 1'b0;
                if (en) counter <= 0; //Might work, point would be to eat multiple orbs
                else if (counter == 500_000_000) 
                begin // 100,000,000 * 5 = 500,000,000
                    state <= DONE;
                end
            end
            
            DONE: 
            begin
                if (!en) 
                begin
                    state <= IDLE;
                    eat_time <= 0;
                    white <= 0;
                end
            end
        endcase
    end
end
endmodule
