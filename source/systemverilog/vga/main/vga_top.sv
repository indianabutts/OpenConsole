
module vga_top(
	       input logic clk_50,
	       input logic n_reset,
			 input logic [9:0]player_x,
			 input logic [8:0]player_y,
	       output logic v_sync,
	       output logic h_sync,
			 output logic blank,
			 output logic sync,
			 output logic pixel_clk,
	       output logic [7:0] red,
	       output logic [7:0] green,
	       output logic [7:0] blue
	       );
			 
   logic 			        bright_wire;
   logic [9:0] 			  h_count_wire;
   logic [8:0] 			  v_count_wire;
   logic [2:0] 			  r_g_b_wire;
	logic clk_25;
	
   assign blank = bright_wire;
	assign sync = 1'b0;
   assign red   = {8{r_g_b_wire[2]}};
   assign green = {8{r_g_b_wire[1]}};
   assign blue  = {8{r_g_b_wire[0]}};
 
   assign pixel_clk=clk_25;
	
	   always_ff@(posedge clk_50 or negedge n_reset)
     begin: clk_25_process
	if (n_reset==0)
	  begin
	     clk_25<=0;
	  end
	else
	  begin
	     clk_25<=!clk_25;
	     
	  end
     end
	

   
   vga_bit_gen inst_vga_gen(
			    .bright(bright_wire),
			    .h_count(h_count_wire),
			    .v_count(v_count_wire),
			    .r_g_b(r_g_b_wire)
			    );
   
   vga_control inst_vga_control(
				.clk_50(clk_50),
				.n_reset(n_reset),
				.v_sync(v_sync),
				.h_sync(h_sync),
				.bright(bright_wire),
				.h_count(h_count_wire),
				.v_count(v_count_wire)
				);

endmodule // vga_top

   
