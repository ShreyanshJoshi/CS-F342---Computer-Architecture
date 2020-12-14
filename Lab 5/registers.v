// NO CHANGES NEED TO BE MADE TO THIS MODULE

`include "dff.v"

module intermediate_reg (input clk, input reset,input regWrite ,input [len-1:0]inR, output[len-1:0] outR);
parameter len = 32;

dff_n #(len) dff_block (clk,reset,regWrite,inR,outR);

endmodule