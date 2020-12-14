`include "mux.v"
`include "dff.v"
`include "memory.v"

module instr_fetch(
    input clk,
    input reset,
    input [31:0] pc_branch,         // the branch address coming from the mem stage
    input pc_source,                // selects between pc+4 (0) or pc+4+branch (1)
    output [31:0] pc_next,          // pc+4 calculated for later stages
    output [31:0] instruction       // the actual instruction corresponding to pc
);

    // Write your code below. Make sure the pc register is initiated with the name "program_counter".

    wire [31:0] in, pc_current;

	mux2to1 #(32) m1 (pc_next, pc_branch, pc_source, in);
	
	dff_p #(32) program_counter(clk, reset, 1'b1, in, pc_current);			// 32 bit register (PC)

	assign pc_next = 32'h00000004 + pc_current;
	
	rom #(32,6) instr_memory (pc_current[7:2], instruction);	// ROM (Instruction Memory, 32 bits wide and 6 address lines)

endmodule
