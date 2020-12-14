// NO CHANGES NEED TO BE MADE TO THE MODULES IN THIS FILE

`ifndef __memory__
`define __memory__ defined

`include "mux.v"

module im (
    input clk,
    input reset,
    input [ad_lines-1:0] address,
    input memRd,
    output [bwidth-1:0] data_out
);

    wire [31:0] data;

    parameter bwidth = 32;
    parameter ad_lines = 6;

    reg [bwidth-1:0] block [0 : (2 ** ad_lines) - 1];

    assign data = block[address];

    mux2to1 #(32) mux_final (32'h0, data, memRd, data_out);

endmodule

`endif