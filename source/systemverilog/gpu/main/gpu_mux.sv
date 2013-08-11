module gpu_mux(
	       input logic 	   sel,
	       input logic [31:0]  a,
	       input logic [31:0]  b,
	       output logic [31:0] out
	       );

   assign out = (sel)?b:a;
   
endmodule // gpu_mux
