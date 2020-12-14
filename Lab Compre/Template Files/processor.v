// NO CHANGES NEED TO BE MADE TO THIS MODULE

`include "dff.v"

`include "instr_fetch.v"
`include "instr_decode.v"
`include "execute.v"
`include "mem_access.v"
`include "write_back.v"

module processor(input clk, input reset);


// ---- Wires whose values are defined in the IF stage ----
    wire [31:0] pc_next_if;
    wire [31:0] instruction_if;
// ---- Wires whose values are defined in the IF stage ----


// ---- Wires whose values are defined in the ID stage ----
    
    wire [31:0] instruction_id;
    wire [31:0] pc_next_id;

    wire reg_write_id;
    wire mem_to_reg_id;
    wire branch_id;
    wire mem_write_id;
    wire mem_read_id;
    wire alu_src_id;
    wire [1:0] alu_op_id;
    wire reg_dst_id;

    wire [31:0] branch_imm_id;
    wire [31:0] rs_data_id;
    wire [31:0] rt_data_id;

// ---- Wires whose values are defined in the ID stage ----


// ---- Wires whose values are defined in the EX stage ----
    
    wire [31:0] pc_next_ex;

    wire reg_write_ex;
    wire mem_to_reg_ex;
    wire branch_ex;
    wire mem_write_ex;
    wire mem_read_ex;
    wire alu_src_ex;
    wire [1:0] alu_op_ex;
    wire reg_dst_ex;

    wire [31:0] branch_imm_ex;
    wire [31:0] rs_data_ex;
    wire [31:0] rt_data_ex;
    wire [4:0] rt_ex;
    wire [4:0] rd_ex;

    wire [31:0] pc_branch_ex;
    wire alu_zero_ex;
    wire [31:0] alu_res_ex;
    wire [4:0] write_reg_ex;

// ---- Wires whose values are defined in the EX stage ----



// ---- Wires whose values are defined in the MEM stage ----

    wire pc_source_mem;
    wire [31:0] pc_branch_mem;

    wire reg_write_mem;
    wire mem_to_reg_mem;
    wire branch_mem;
    wire mem_write_mem;
    wire mem_read_mem;

    wire alu_zero_mem;
    wire [31:0] alu_res_mem;
    wire [31:0] rt_data_mem;
    wire [4:0] write_reg_mem;

    wire [31:0] read_data_mem;

// ---- Wires whose values are defined in the MEM stage ----



// ---- Wires whose values are defined in the WB stage ----

    wire reg_write_wb;
    wire mem_to_reg_wb;

    wire [31:0] read_data_wb;

    wire [31:0] alu_res_wb;
    wire [31:0] write_data_wb;
    wire [4:0] write_reg_wb;

// ---- Wires whose values are defined in the WB stage ----




// instruction fetch
    instr_fetch if_main(clk, reset, pc_branch_mem, pc_source_mem, pc_next_if, instruction_if);
// instruction fetch


// ---- if-id pipeline registers ----
    dff_p #(32) pr0_pc_next (clk, reset, 1'b1, pc_next_if, pc_next_id);
    dff_p #(32) pr0_instr (clk, reset, 1'b1, instruction_if, instruction_id);
// ---- if-id pipeline registers ----


// instruction decode

    instr_decode id_main(
        
        clk,
        reset,

        instruction_id,
        reg_write_wb,
        write_data_wb,
        write_reg_wb,

        reg_write_id,
        mem_to_reg_id,
        branch_id,
        mem_write_id,
        mem_read_id,
        alu_src_id,
        alu_op_id,
        reg_dst_id,

        branch_imm_id,
        rs_data_id,
        rt_data_id

    );

// instruction decode



// ---- id/ex pipeline registers ----
    
    dff_p #(32) pr1_pc_next (clk, reset, 1'b1, pc_next_id, pc_next_ex);

    // at times, different signals could be concatenated rather than having to declare different dff_ps for each
    // this concatenation can be done using curly braces. each of the wires inside the {} must be declared separately 
    dff_p #(5)  pr1_control_upper (
        clk, reset, 1'b1,
        {reg_write_id, mem_to_reg_id, branch_id, mem_write_id, mem_read_id},
        {reg_write_ex, mem_to_reg_ex, branch_ex, mem_write_ex, mem_read_ex}
    );
    dff_p #(4)  pr1_control_lower (
        clk,
        reset,
        1'b1,
        {alu_src_id, alu_op_id, reg_dst_id},
        {alu_src_ex, alu_op_ex, reg_dst_ex}
    );

    dff_p #(32) pr1_branch_imm (clk, reset, 1'b1, branch_imm_id, branch_imm_ex);
    dff_p #(32) pr1_rs_data (clk, reset, 1'b1, rs_data_id, rs_data_ex);
    dff_p #(32) pr1_rt_data (clk, reset, 1'b1, rt_data_id, rt_data_ex);
    dff_p #(5)  pr1_rt (clk, reset, 1'b1, instruction_id[20:16], rt_ex);
    dff_p #(5)  pr1_rd (clk, reset, 1'b1, instruction_id[15:11], rd_ex);

// ---- id/ex pipeline registers ----



// execute stage
    execute ex_main(

        alu_src_ex,
        alu_op_ex,
        reg_dst_ex,
        pc_next_ex,
        branch_imm_ex,
        rs_data_ex,
        rt_data_ex,
        rt_ex,
        rd_ex,

        pc_branch_ex,
        alu_zero_ex,
        alu_res_ex,
        write_reg_ex

    );
// execute stage


// ---- ex/mem pipeline registers ----

    dff_p #(32) pr2_pc_branch (clk, reset, 1'b1, pc_branch_ex, pc_branch_mem);

    dff_p #(2)  pr2_control_upper (
        clk, reset, 1'b1,
        {reg_write_ex, mem_to_reg_ex},
        {reg_write_mem, mem_to_reg_mem}
    );
    dff_p #(3)  pr2_control_lower (
        clk, reset, 1'b1,
        {branch_ex, mem_write_ex, mem_read_ex},
        {branch_mem, mem_write_mem, mem_read_mem}
    );

    dff_p #(1)  pr2_alu_zero (clk, reset, 1'b1, alu_zero_ex, alu_zero_mem);
    dff_p #(32) pr2_alu_res (clk, reset, 1'b1, alu_res_ex, alu_res_mem);
    dff_p #(32) pr2_rt_data (clk, reset, 1'b1, rt_data_ex, rt_data_mem);
    dff_p #(5)  pr2_write_reg (clk, reset, 1'b1, write_reg_ex, write_reg_mem);

// ---- ex/mem pipeline registers ----


// memory access
    
    mem_access mem_main(
        
        clk,
        reset,
        branch_mem,
        alu_zero_mem,
        mem_write_mem,
        mem_read_mem,
        alu_res_mem,
        rt_data_mem,

        pc_source_mem,
        read_data_mem

    );

// memory access

// ---- mem/wb pipeline registers ----

    dff_p #(2)  pr3_reg_write (
        clk, reset, 1'b1,
        {reg_write_mem, mem_to_reg_mem},
        {reg_write_wb, mem_to_reg_wb}
    );
    dff_p #(32) pr3_read_data (clk, reset, 1'b1, read_data_mem, read_data_wb);
    dff_p #(32) pr3_alu_res (clk, reset, 1'b1, alu_res_mem, alu_res_wb);
    dff_p #(5)  pr3_write_reg (clk, reset, 1'b1, write_reg_mem, write_reg_wb);

// ---- mem/wb pipeline registers ----

// write back
    write_back wb_main(mem_to_reg_wb, alu_res_wb, read_data_wb, write_data_wb);
// write back

endmodule
