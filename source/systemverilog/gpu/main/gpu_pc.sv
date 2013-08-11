module gpu_pc(
	      input clk,
	      input reset,
	      input [31:0] input_pc,
	      output [31:0] output_pc
	      );

   always_ff@(posedge clk or posedge reset)
     begin
	if (reset)
	  output_pc <= 0;
	else
	  output_pc<=input_pc;
	
     end


endmodule // gpu_pc
