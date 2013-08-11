module gpu_if_stage(
		    input logic [31:0] updated_pc,
		    output logic [31:0] if_id_reg_instruction,
		    output logic [31:0] if_id_reg_next_pc
		    );


   logic [31:0] 			output_pc_wire;
   logic [31:0] 			instruction_mem_out_wire;
   
   gpu_pc inst_pc (
		   .clk(clk),
		   .reset(reset),
		   .input_pc(updated_pc),
		   .output_pc(output_pc_wire)
		   );
   
   gpu_i_cache inst_i_cache(
			    );
   
   assign   if_stage_instruction_out = instruction_mem_out_wire;
   assign   if_stage_next_pc_out = output_pc_wire+4;
   

endmodule // gpu_if
