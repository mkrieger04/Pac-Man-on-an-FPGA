module scorereg (
    input logic clk,
    input logic reset,
    input logic scoreUpdate,
    output logic [11:0] scoreout,
    output logic won
);

    logic [11:0] score; 

    always_ff @(posedge clk or posedge reset)
    begin
        if (reset) 
            begin
            score <= 8'h00;
            won <= 0;
            end
        else if (scoreUpdate) 
            begin
            score <= score + 1'b1;
            if (score == 12'h1de || score == 12'h1df) won <= 1'b1;
            end

    end

    assign scoreout = score; 

endmodule

