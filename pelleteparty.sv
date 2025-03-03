module pelleteparty( 
       input logic [8:0] read,
       output logic scoreUpdate,
       output logic wea,
       output logic start_the_count,
       output logic [8:0] douta
    );
        
    always_comb 
    begin
        if (read == 9'h063) //reg pellet
            begin
                wea = 1'b1;
                douta = 9'h000;
                 scoreUpdate = 1'b1;
                 start_the_count = 1'b0;
            end
            
        else if (read == 9'h062) //power pellet
            begin
                wea = 1'b1;
                douta = 9'h000;
                scoreUpdate = 1'b0;
                start_the_count = 1'b1;
            end
            
        else
            begin
                wea = 1'b0;
                douta = 9'bxxxxxxxxx;
                scoreUpdate = 1'b0;
                start_the_count = 1'b0;
            end
    end
endmodule
