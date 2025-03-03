
module Scoretodec(
        input logic [11:0] scorein,
        
        output logic [3:0] cien,
        output logic [3:0] diez,
        output logic [3:0] uno
    );
    
always_comb
begin
    uno = scorein %10;
    cien = scorein/100;
    diez = (scorein/10)%10;
end
    
    
    
    
    
endmodule
