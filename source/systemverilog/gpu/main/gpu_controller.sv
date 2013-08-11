//Instructions to Implement
//NOP
//ADD
//ADDI
//ADDU
//ADDIU
//SUB
//SUBU
//MULT
//MULTU
//DIV
//DIVU 
//SRL
//SRA
//SLL
//MFHI
//MFLO
//MTHI
//MTLO
//AND
//OR
//NOR
//NAND
//XOR
//CMP
//BEQ
//BNE
//JR
//J

module gpu_controller(
		      input logic [4:0]  opcode,
		      output logic [3:0] alu_op,
		      output logic 	 i_mode,
		      output logic 	 r_mode,
		      output logic 	 branch_mode,
		      output logic 	 compare_mode
		      );

   always_comb
     begin
	case(opcode)
	  
	endcase // case (opcode)
	
     end
endmodule // gpu_controller
