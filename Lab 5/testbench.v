`timescale 1ns / 1ns
`include "multi_cycle.v"

module testbench();
    reg clk;
    reg reset;
    wire [31:0] result;
    multi_cycle mc (clk, reset, result);

    always
    #5 clk=~clk;
    
    initial
    begin
        $dumpfile("2018A7PS0097G_Lab5.vcd");
        $dumpvars;
        clk=0; reset=1;
        #5  reset=0;
        $readmemh("instr.mem", mc.instruction_memory.block, 5'h00, 5'h1f);	
        #350 $finish;
    end
endmodule