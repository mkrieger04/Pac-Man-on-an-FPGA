module lives(
    input logic clk,
    input logic reset,
    input logic [3:0] collide,
    output logic [3:0] livesout,
    output logic lost
    );
    
    logic [3:0] lives_local; 
    logic stop;

    always_ff @(posedge clk or posedge reset)
    begin
        if (reset) 
            begin
            lives_local <= 4'b0011;
            lost <= 1'b0;
            end
            
        else if (lives_local == 4'b0000)
            lost <= 1'b1;
               
        else if (collide == 4'b0001 && ~stop)
            begin
            lives_local <= lives_local - 1'b1;
            stop = 1'b1;
            end
            
        else
            stop = 1'b0;
         
    end

    assign livesout = lives_local; 

endmodule
