`include "memory.v"

module mem_access(

    input clk,
    input reset,

    input branch,
    input alu_zero,
    input mem_write,
    input mem_read,

    input [31:0] alu_res,       // the alu result is used to calculate the memory address that needs to be read from or written to
    input [31:0] rt_data,       // whereas the actual data that's written into memory (only if mem_write is 1) is given by the value of rt

    output pc_source,           // the final branch signal is selects the source for pc (out pc_next and pc_branch)
    output [31:0] read_data

);

    // Write your code below. Make sure that the ram is instantiated with the name "data_memory".

    and a1(pc_source, branch, alu_zero);

    ram #(32,4) data_memory (clk, reset, mem_write, mem_read, alu_res[5:2], rt_data, read_data);
    

endmodule
