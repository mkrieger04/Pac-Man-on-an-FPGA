module collision(
    input logic[12:0] pac,
    input logic[12:0] clyde,
    input logic[12:0] stinky,
    input logic[12:0] tinky,
    input logic eat_time,
    
    output logic[3:0] collide
    );
    
    always_comb
    begin
    if(eat_time)
    begin
    if(pac == clyde || pac == stinky || pac == tinky)
    begin
        if(pac == clyde)
        begin
            collide =  4'b1000;
        end
        else if (pac == stinky)
        begin
            collide = 4'b0100;
        end
        else if(pac == tinky)
        begin
            collide = 4'b0010;
        end
        else
            collide = 4'b0000;
    end
    else collide = 4'b0000;
    end
    else
    begin
        if(pac == clyde || pac == stinky || pac == tinky)
        begin
        collide = 4'b0001;
        end
        else collide = 4'b0000;
    end
    end
endmodule
