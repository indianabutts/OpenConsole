module vga_frame_buffer #(
				   parameter frame_width =256,
				   parameter frame_height = 256
				   )
                                   (
				    input logic clk,
				    input logic        data_in_valid,       
				    input logic [7:0]  image_data_in,
				    input logic [9:0]  x_position_vga,
				    input logic [8:0]  y_position_vga,
				    output logic [7:0] vga_data_out 	   
				    );

   logic [31:0] 				       frame_buffer [frame_width*frame_height-1:0];
	logic [31:0] rs232_data_counter;
   parameter top_limit = (480-frame_height)/2;
	parameter left_limit = (640-frame_width)/2;
	
   always_ff@(posedge data_in_valid)
     begin:uart_to_buffer
	if(data_in_valid)
	  begin
	     frame_buffer[0+rs232_data_counter*8]<=image_data_in[0];
	     frame_buffer[1+rs232_data_counter*8]<=image_data_in[1];
	     frame_buffer[2+rs232_data_counter*8]<=image_data_in[2];
	     frame_buffer[3+rs232_data_counter*8]<=image_data_in[3];
	     frame_buffer[4+rs232_data_counter*8]<=image_data_in[4];
	     frame_buffer[5+rs232_data_counter*8]<=image_data_in[5];
	     frame_buffer[6+rs232_data_counter*8]<=image_data_in[6];
	     frame_buffer[7+rs232_data_counter*8]<=image_data_in[7];
		  rs232_data_counter<=rs232_data_counter+1;
	  end
     end // block: uart_to_buffer

   initial
     $readmemh("frame.hexa",frame_buffer);
   
   always_ff@(posedge clk)
     begin:buffer_to_vga
	   vga_data_out<=frame_buffer[(x_position_vga-left_limit) + (y_position_vga-top_limit)*frame_width];
     end
   

   
endmodule // vga_frame_buffer

   
