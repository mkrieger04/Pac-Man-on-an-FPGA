module background_ram(
    input logic [12:0] r_addra, r_addra2,
    input logic [12:0] w_addra, w_addra2,
    input logic Clk,
    input logic wea, wea2,
    input logic [8:0] dina, dina2,
    output logic [8:0] douta, douta2   
    );
    
    logic [11:0] block_mem [0:4799];
    
    initial
    begin
        $readmemh("backgroundbc.txt", block_mem);
    end
    
    always_ff @ (posedge Clk) begin
//        if (wea)
//            block_mem[w_addra] <= dina; //score update
            
        if (wea2)
            block_mem[w_addra2] <= dina2; //eating
            
        douta <= block_mem[r_addra][8:0];
        douta2 <= block_mem[r_addra2][8:0];
    end
endmodule

