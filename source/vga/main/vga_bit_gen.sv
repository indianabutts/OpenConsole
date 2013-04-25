module vga_bit_gen(
		   input logic bright,
		   input logic [9:0] h_count,
		   input logic [8:0] v_count,
		   output logic [2:0] r_g_b
		   );

   parameter black = 3'b000;
   parameter white = 3'b111;
   parameter red   = 3'b100;
   parameter green = 3'b010;
   parameter blue  = 3'b001;
   
	parameter smile = 2'b01;
	parameter red_fb = 2'b00;
	
	logic [1:0] frame_buffer[79:0][59:0];
   
	frame_buffer[0][0] = smile;
	
   always_latch
     begin
	    r_g_b=frame_buffer
     end   
  


   
endmodule // vga_bit_gen

   
