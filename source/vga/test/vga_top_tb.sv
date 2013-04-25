module vga_top_tb;
   
   logic clk_50;
   logic n_reset;
   logic v_sync;
   logic h_sync;
   logic blank;
   logic sync;
   logic [7:0] red;
   logic [7:0] green;
   logic [7:0] blue;

   always
     begin:clk_proc
        #10ns clk_50=!clk_50;
     end

   initial
     begin
	n_reset=0;
	clk_50=0;
	#10ns n_reset=1;
     end

   vga_top inst_vga (.*);
   
   
endmodule // vga_control_tb
