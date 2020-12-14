// NO CHANGES NEED TO BE MADE TO THIS MODULE

`ifndef __rf__
`define __rf__ defined

`include "decoder.v"
`include "dff.v"

module register_file (
    input clk,
    input reset,
    input write,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [31:0] data_in,
    output [31:0] data_out0,
    output [31:0] data_out1
);

    wire [31:0] register_outs [0:31];
    wire [31:0] write_signal;

    decoder #(5) decoder_write (rd, write_signal);

    genvar i_reg;
    generate
        for (i_reg = 0; i_reg < 32; i_reg = i_reg + 1) begin : rf_gen
            dff_n #(32) register (clk, reset, write & write_signal[i_reg], data_in, register_outs[i_reg]);
        end
    endgenerate

    assign data_out0 = register_outs[rs];
    assign data_out1 = register_outs[rt];

endmodule

`endif