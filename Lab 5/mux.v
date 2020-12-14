// NO CHANGES NEED TO BE MADE TO THE MODULES IN THIS FILE

`ifndef __mux_v__
`define __mux_v__ defined

module mux2to1 (
    input [bwidth-1:0] in0,
    input [bwidth-1:0] in1,
    input sel,
    output [bwidth-1:0] out
);

    parameter bwidth = 1;

    wire [bwidth-1:0] select_bus;

    assign select_bus = {bwidth{sel}};
    assign out = (in0 & (~select_bus)) | (in1 & (select_bus));

endmodule

module mux4to1 (
    input [bwidth-1:0] in0,
    input [bwidth-1:0] in1,
    input [bwidth-1:0] in2,
    input [bwidth-1:0] in3,
    input [1:0] sel,
    output [bwidth-1:0] out
);

    parameter bwidth = 1;

    wire [bwidth-1:0] stage0_output0;
    wire [bwidth-1:0] stage0_output1;

    mux2to1 #(bwidth) mux_stage0_0 (in0, in1, sel[0], stage0_output0);
    mux2to1 #(bwidth) mux_stage0_1 (in2, in3, sel[0], stage0_output1);

    mux2to1 #(bwidth) mux_stage1 (stage0_output0, stage0_output1, sel[1], out);

endmodule

`endif