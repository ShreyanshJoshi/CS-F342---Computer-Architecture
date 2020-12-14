// CHANGE THE NAME OF THE .vcd DUMPFILE ACCORDING TO YOUR ID on line 57
// DO NOT MAKE ANY OTHER CHANGES, IT MIGHT CAUSE THE TESTBENCH TO FAIL

`timescale 1ns / 1ns
`include "processor.v"

module testbench ();

    reg a_fault0, a_fault1, a_fault2;

    wire [31:0] reg_1;
    wire [31:0] reg_2;
    wire [31:0] reg_3;
    wire [31:0] reg_4;
    wire [31:0] reg_5;
    wire [31:0] reg_6;

    wire [31:0] dm_3;
    wire [31:0] dm_4;
    wire [31:0] dm_5;
    wire [31:0] dm_6;
    wire [31:0] dm_7;
    wire [31:0] dm_8;
    wire [31:0] dm_9;
    wire [31:0] dm_10;
    wire [31:0] dm_11;

    wire [31:0] program_count;

    reg reset;
    reg clk;

    processor multi_cycle (clk, reset);

    assign reg_1 = multi_cycle.id_main.rf_main.rf_gen[1].register.out[31:0];
    assign reg_2 = multi_cycle.id_main.rf_main.rf_gen[2].register.out[31:0];
    assign reg_3 = multi_cycle.id_main.rf_main.rf_gen[3].register.out[31:0];
    assign reg_4 = multi_cycle.id_main.rf_main.rf_gen[4].register.out[31:0];
    assign reg_5 = multi_cycle.id_main.rf_main.rf_gen[5].register.out[31:0];
    assign reg_6 = multi_cycle.id_main.rf_main.rf_gen[6].register.out[31:0];

    assign dm_3 = multi_cycle.mem_main.data_memory.block[3];
    assign dm_4 = multi_cycle.mem_main.data_memory.block[4];
    assign dm_5 = multi_cycle.mem_main.data_memory.block[5];
    assign dm_6 = multi_cycle.mem_main.data_memory.block[6];
    assign dm_7 = multi_cycle.mem_main.data_memory.block[7];
    assign dm_8 = multi_cycle.mem_main.data_memory.block[8];
    assign dm_9 = multi_cycle.mem_main.data_memory.block[9];
    assign dm_10 = multi_cycle.mem_main.data_memory.block[10];
    assign dm_11 = multi_cycle.mem_main.data_memory.block[11];

    assign program_count = multi_cycle.if_main.program_counter.out[31:0];

    initial begin

    // standard commands to store testbench results
        $dumpfile("2018A7PS0097G_Labtest.vcd");
        $dumpvars;

    // reset everything at first, initialise clock to 1
        reset = 1;
        clk = 1;
        #1;

    // once everything is reset, make reset low and load data into the rom and ram
        reset = 0;
        $readmemh("instr.mem", multi_cycle.if_main.instr_memory.block);
        $readmemh("data.mem", multi_cycle.mem_main.data_memory.block);
        #1;

    // let the processor run for ~246 cycles
        #2468;

    // at the end, check faults and display messages
        if ((a_fault0 | a_fault1 | a_fault2) == 1'b0)
            $display("\nAll outputs correct; Testbench matched fully.\n");
        else
            $display("\nErrors found.\n");

        #40;
        $finish;

    end

    always begin
        #5;
        clk = ~clk;
    end

    initial begin
        a_fault0 <= 1'b0;
        #5;
        while($time < 195) begin
            #10;
            a_fault0 = a_fault0 | ~(program_count == (($time-5)*4/10));
        end
    end

    initial begin
        a_fault1 <= 1'b0;
        #200;
        a_fault1 <= (
            (reg_1 != 32'h7)    |
            (reg_2 != 32'h100)  |
            (reg_3 != 32'h200)  |
            (reg_4 != 32'h10)   |
            (reg_5 != 32'h100)  |
            (reg_6 != 32'h1)
        );
    end

    initial begin
        a_fault2 <= 1'b0;
        #2250;
        a_fault2 <= (
            (dm_3 != 32'h100)  |
            (dm_4 != 32'h200)  |
            (dm_5 != 32'h150)  |
            (dm_6 != 32'h200)  |
            (dm_7 != 32'h0)    |
            (dm_8 != 32'h200)  |
            (dm_9 != 32'h1ff)  |
            (dm_10 != 32'h120) |
            (dm_11 != 32'h30)  |
            (reg_1 != 32'h0)   | 
            (reg_2 != 32'h0)   | 
            (reg_3 != 32'h0)   | 
            (reg_4 != 32'h0)   | 
            (reg_5 != 32'h0)   | 
            (reg_6 != 32'h0)
        );
    end

endmodule
