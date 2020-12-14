// NO CHANGES NEED TO BE MADE TO THIS MODULE

`ifndef __signext__
`define __signext__ defined

module sign_ext (in, out);

    parameter in_width = 16;
    parameter out_width = 32;

    output [out_width-1:0] out;
    input [in_width-1:0] in;

    assign out[out_width-1:in_width] = {(out_width-in_width){in[in_width-1]}};
    assign out[in_width-1:0] = in;

endmodule

`endif