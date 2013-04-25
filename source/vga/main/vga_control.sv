module vga_control(
		   input logic clk_50,
		   input logic n_reset,
		   output logic v_sync,
		   output logic h_sync,
		   output logic bright,
		   output logic [9:0] h_count,
		   output logic [8:0] v_count
		   );

   logic 			      clk_25;

   logic [6:0] 			      h_timing_counter;
   
   enum 			      {T_PW,T_BP,T_FP,T_DISP} h_phase,v_phase;


   assign bright = (h_phase==T_DISP && v_phase==T_DISP)?1:0;
     

   always_ff@(posedge clk_25 or negedge n_reset)
     begin:horizontal_timings
	if (n_reset==0)
	  begin
	     h_phase<=T_PW;
	     h_timing_counter<=0;
	     h_sync<=1;
	  end
	else
	  begin
	     h_timing_counter<=0;
	     h_sync<=1;
	     case(h_phase)
	       T_PW:
		 begin
		    h_sync<=0;
		    if (h_timing_counter==95)
		      h_phase<=T_BP;
		    else
		      h_timing_counter<=h_timing_counter+1;
		 end
	       T_BP:
		 begin
		    if (h_timing_counter==47)
		      h_phase<=T_DISP;
		    else
		      h_timing_counter<=h_timing_counter+1;
		 end
	       T_DISP:
		 begin
		    if (h_count==639)
		      h_phase<=T_FP;
		 end
	       T_FP:
		 begin
		    if(h_timing_counter==15)
		      h_phase<=T_PW;
		    else
		      h_timing_counter<=h_timing_counter+1;
		 end
	     endcase // case (h_phase)
	     
	  end
	  
     end
   
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
   
   always_ff@(posedge clk_25 or negedge n_reset)
     begin:horizontal_display_timer
	if (n_reset==0)
	  begin
	     h_count<=0;
	  end
	else
	  begin
	  if(h_phase!=T_DISP)
		  h_count<=0;
	  else
	     h_count<=h_count+1;
		  
	     if (h_count==639)
	       begin
		  h_count<=0;
	       end
	  end
     end
	     
   always_ff@(posedge h_sync or negedge n_reset)
     begin:vertical_display_timer
	if (n_reset==0)
	  begin
	     v_count<=0;
	  end
	else
	  begin
	  	  if(v_phase!=T_DISP)
			v_count<=0;
		  else
	      v_count<=v_count+1;
			
	     if (v_count==479)
	       begin
		  v_count<=0;
	       end
	  end
     end   

   logic [4:0] v_timing_counter;
   
   always_ff@(posedge h_sync or negedge n_reset)
     begin: vertical_timings
	if (n_reset==0)
	  begin
	     v_phase<=T_PW;
	     v_timing_counter<=0;
	     v_sync<=1;
	  end
	else
	  begin
	     v_timing_counter<=0;
	     v_sync<=1;
	     case(v_phase)
	       T_PW:
		 begin
		    v_sync<=0;
		    if (v_timing_counter==1)
		      v_phase<=T_BP;
		    else
		      v_timing_counter<=v_timing_counter+1;
		 end
	       T_BP:
		 begin
		    if (v_timing_counter==28)
		      v_phase<=T_DISP;
		    else
		      v_timing_counter<=v_timing_counter+1;
		 end
	       T_DISP:
		 begin
		    if (v_count==479)
		      v_phase<=T_FP;
		 end
	       T_FP:
		 begin
		    if(v_timing_counter==9)
		      v_phase<=T_PW;
		    else
		      v_timing_counter<=v_timing_counter+1;
		 end
	     endcase // case (v_phase)
	     
	  end
	  
     end
endmodule // vga_control

   
