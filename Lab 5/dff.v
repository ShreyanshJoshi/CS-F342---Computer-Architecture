// NO CHANGES NEED TO BE MADE TO THE MODULES IN THIS FILE

`ifndef __dff__
`define __dff__ defined

// DFF that triggers on the positive clock edge
module dff_p (input clk, input reset, input write, input [bwidth-1:0] in, output reg [bwidth-1:0] out);

    // default bit width of the DFF is 1
    parameter bwidth = 1;
    
    always @(posedge clk)
        if (reset == 1'b0)
            if (write == 1'b1)
                out <= in;

    always @(reset)
        if (reset == 1'b1)
            out <= 0;

endmodule

// DFF that triggers on the negative clock edge
module dff_n (
    input clk,
    input reset,
    input write,
    input [bwidth-1:0] in,
    output reg [bwidth-1:0] out
);

    parameter bwidth = 1;

    always @(negedge clk)
        if (reset == 1'b0)
            if (write == 1'b1)
                out <= in;

    always @(reset)
        if (reset == 1'b1)
            out <= 0;

endmodule

`endif