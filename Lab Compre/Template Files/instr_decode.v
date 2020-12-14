`include "register_file.v"
`include "control.v"
`include "mux.v"
`include "sign_ext.v"

module instr_decode (

    input clk,
    input reset,

    input [31:0] instruction,
    input reg_write_in,             // not to be confused with reg_write_out
    input [31:0] write_data,
    input [4:0] write_reg,

    output reg_write_out,           // not to be confused with reg_write_in
    output mem_to_reg,
    output branch,                  // not to be confused with branch_imm
    output mem_write,
    output mem_read,
    output alu_src,
    output [1:0] alu_op,
    output reg_dst,

    output [31:0] branch_imm,        // not to be confused with branch
    output [31:0] rs_data,
    output [31:0] rt_data

);

    // Write your code below.

    // * Make sure that the register file is instantiated with the name "rf_main".

endmodule