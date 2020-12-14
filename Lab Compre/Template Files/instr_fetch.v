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

    // Write your code below.

    // * Make sure the pc register is initiated with the name "program_counter".

endmodule