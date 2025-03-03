module livefont ( input [2:0]	addr,
				  output [7:0]	data
					 );

	parameter ADDR_WIDTH = 3;
	parameter DATA_WIDTH =  8;
	logic [ADDR_WIDTH-1:0] addr_reg;
				
	// ROM definition				
	parameter [0:2**ADDR_WIDTH-1][DATA_WIDTH-1:0] ROM = {
	   //code x01
        8'b00111100, // 8    ** **
        8'b01111110, // 9    ** **
        8'b00011111, // a    ** **
        8'b00000111, // b    ** **
        8'b00011111, // c
        8'b01111110, // d
        8'b00111100, // e
        8'b00000000 // f
      };

	assign data = ROM[addr];

endmodule  