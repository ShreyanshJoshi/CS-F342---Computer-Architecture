// NO CHANGES NEED TO BE MADE TO THIS MODULE

`ifndef __decoder__
`define __decoder__ defined

module decoder (
    input [ad_lines - 1 : 0] address,
    output [(2 ** ad_lines) - 1 : 0] out
);

    parameter ad_lines = 4;
    assign out = 1'b1 << address;

endmodule

`endif