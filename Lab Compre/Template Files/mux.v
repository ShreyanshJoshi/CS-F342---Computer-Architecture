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

module mux8to1 (
    input [bwidth-1:0] in0,
    input [bwidth-1:0] in1,
    input [bwidth-1:0] in2,
    input [bwidth-1:0] in3,
    input [bwidth-1:0] in4,
    input [bwidth-1:0] in5,
    input [bwidth-1:0] in6,
    input [bwidth-1:0] in7,
    input [2:0] sel,
    output [bwidth-1:0] out
);

    parameter bwidth = 1;

    wire [bwidth-1:0] stage0_output0;
    wire [bwidth-1:0] stage0_output1;

    mux4to1 #(bwidth) mux_stage0_0 (in0, in1, in2, in3, sel[1:0], stage0_output0);
    mux4to1 #(bwidth) mux_stage0_1 (in4, in5, in6, in7, sel[1:0], stage0_output1);
    
    mux2to1 #(bwidth) mux_stage1 (stage0_output0, stage0_output1, sel[2], out);

endmodule

module mux16to1 (
    input [bwidth-1:0] in0,
    input [bwidth-1:0] in1,
    input [bwidth-1:0] in2,
    input [bwidth-1:0] in3,
    input [bwidth-1:0] in4,
    input [bwidth-1:0] in5,
    input [bwidth-1:0] in6,
    input [bwidth-1:0] in7,
    input [bwidth-1:0] in8,
    input [bwidth-1:0] in9,
    input [bwidth-1:0] in10,
    input [bwidth-1:0] in11,
    input [bwidth-1:0] in12,
    input [bwidth-1:0] in13,
    input [bwidth-1:0] in14,
    input [bwidth-1:0] in15,
    input [3:0] sel,
    output out
);

    parameter bwidth = 1;

    wire [bwidth-1:0] stage0_output0;
    wire [bwidth-1:0] stage0_output1;

    mux8to1 #(bwidth) mux_stage0_0 (in0, in1, in2, in3, in4, in5, in6, in7, sel[2:0], stage0_output0);
    mux8to1 #(bwidth) mux_stage0_1 (in8, in9, in10, in11, in12, in13, in14, in15, sel[2:0], stage0_output1);

    mux2to1 #(bwidth) mux_stage1 (stage0_output0, stage0_output1, sel[3], out);

endmodule

module mux32to1 (
    input [bwidth-1:0] in0, input [bwidth-1:0] in1,
    input [bwidth-1:0] in2, input [bwidth-1:0] in3,
    input [bwidth-1:0] in4, input [bwidth-1:0] in5,
    input [bwidth-1:0] in6, input [bwidth-1:0] in7,
    input [bwidth-1:0] in8, input [bwidth-1:0] in9,
    input [bwidth-1:0] in10, input [bwidth-1:0] in11,
    input [bwidth-1:0] in12, input [bwidth-1:0] in13,
    input [bwidth-1:0] in14, input [bwidth-1:0] in15,
    input [bwidth-1:0] in16, input [bwidth-1:0] in17,
    input [bwidth-1:0] in18, input [bwidth-1:0] in19,
    input [bwidth-1:0] in20, input [bwidth-1:0] in21,
    input [bwidth-1:0] in22, input [bwidth-1:0] in23,
    input [bwidth-1:0] in24, input [bwidth-1:0] in25,
    input [bwidth-1:0] in26, input [bwidth-1:0] in27,
    input [bwidth-1:0] in28, input [bwidth-1:0] in29,
    input [bwidth-1:0] in30, input [bwidth-1:0] in31,
    input [4:0] sel,
    output out
);

    parameter bwidth = 1;

    wire [bwidth-1:0] stage0_output0;
    wire [bwidth-1:0] stage0_output1;

    mux16to1 #(bwidth) mux_stage0_0 (in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, sel[3:0], stage0_output0);
    mux16to1 #(bwidth) mux_stage0_1 (in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, sel[3:0], stage0_output1);

    mux2to1 #(bwidth) mux_stage1 (stage0_output0, stage0_output1, sel[4], out);

endmodule

`endif