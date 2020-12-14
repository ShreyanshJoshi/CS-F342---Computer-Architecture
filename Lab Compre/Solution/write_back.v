`include "mux.v"

module write_back (

    input mem_to_reg,
    input [31:0] alu_res,
    input [31:0] read_data,

    output [31:0] write_data_out

);

    // Write your code below.

    mux2to1 #(32) m4(alu_res, read_data, mem_to_reg, write_data_out);
    
endmodule
