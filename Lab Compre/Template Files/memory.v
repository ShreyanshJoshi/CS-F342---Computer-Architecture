// NO CHANGES NEED TO BE MADE TO THE MODULES IN THIS FILE

`ifndef __memory__
`define __memory__ defined

`include "mux.v"

module rom (
    input [ad_lines-1:0] address,
    output [bwidth-1:0] data_out
);

    parameter bwidth = 32;
    parameter ad_lines = 6;

    // the reg keyword can be used to specify modules that retain their value
    // even though "block" is not an output, it can be referenced as a whole in upper level modules
    reg [bwidth-1:0] block [0 : (2 ** ad_lines) - 1];

    // the following statement assigns ONE location's value to data_out
    // the location is determined by the address
    assign data_out = block[address];

endmodule

module ram (
    input clk,
    input reset,
    input write,
    input read,
    input [ad_lines-1:0] address,
    input [bwidth-1:0] data_in,
    output [bwidth-1:0] data_out
);

    parameter bwidth = 32;
    parameter ad_lines = 6;

    wire [bwidth-1:0] mem_data;

    // as declared in rom, block would retain its values since it's declared as a reg
    reg [bwidth-1:0] block [0 : (2 ** ad_lines) - 1];
    assign mem_data = block[address];
    // the assign statement takes care of the reading functionality

    mux2to1 #(bwidth) mux_mem_read (32'hxxxxxxxx, mem_data, read, data_out);

    // the write functionality has been taken care of below

    // whenever clk goes low (and reset == 0 and write == 1), store data_in into the address'th location of block
    always @(negedge clk)
        if (reset == 1'b0 && write == 1'b1)
            block[address] <= data_in;

    // the following statement takes care of the reset functionality
    integer i;
    always @(reset)
        if (reset == 1'b1)
            for (i = 0; i < 2 ** ad_lines; i = i + 1)
                block[i] <= {bwidth-1{1'b0}};
                // the integer, i, iterates through each location in block to reset it
                // in simulation time, all these iterations are instantaneous

endmodule

`endif