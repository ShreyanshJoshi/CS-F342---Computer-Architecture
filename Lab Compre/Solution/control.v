// NO CHANGES NEED TO BE MADE TO THIS MODULE

`ifndef __ctrl__
`define __ctrl__ defined

module control (
    input [5:0] opcode,
    output reg reg_write,       // (used in the wb stage)   specifies if or not a register be written to
    output reg mem2reg,         // (used in the wb stage)   selects between (data) memory data and the alu result
    output reg branch,          // (used in the mem stage)  selects between the next address and the branch address
    output reg mem_write,       // (used in the mem stage)  specifies whether the memory should be written to or not
    output reg mem_read,        // (used in the mem stage)  specifies whether the memory should be read from or not
    output reg alu_src,         // (used in the ex stage)   selects between (rs data) and (extended immediate data) as the alu's 2nd operand
    output reg [1:0] alu_op,    // (used in the ex stage)   provides the alu control unit a key to select the operation
    output reg reg_dest         // (used in the ex stage)   specifies which out of rt and rd should used as the destination register
);

    always @(*) begin
        case (opcode)
            6'h00 : begin                   // for R type instructions (and, or, add, sub, slt)
                reg_write   = 1'b1;
                mem2reg     = 1'b0;
                branch      = 1'b0;
                mem_write   = 1'b0;
                mem_read    = 1'b0;
                alu_src     = 1'b0;
                alu_op      = 2'b10;
                reg_dest    = 1'b1;
            end
            6'h04 : begin                   // for (I type) branch instructions (beq)
                reg_write   = 1'b0;
                mem2reg     = 1'b0;
                branch      = 1'b1;
                mem_write   = 1'b0;
                mem_read    = 1'b0;
                alu_src     = 1'b0;
                alu_op      = 2'b01;
                reg_dest    = 1'bx;
            end
            6'h08 : begin                   // for (I type) immediate instructions (addi)
                reg_write   = 1'b1;
                mem2reg     = 1'b0;
                branch      = 1'b0;
                mem_write   = 1'b0;
                mem_read    = 1'b0;
                alu_src     = 1'b1;
                alu_op      = 2'b00;
                reg_dest    = 1'b0;
            end
            6'h23 : begin                   // for (I type) memory to register instructions (lw)
                reg_write   = 1'b1;
                mem2reg     = 1'b1;
                branch      = 1'b0;
                mem_write   = 1'b0;
                mem_read    = 1'b1;
                alu_src     = 1'b1;
                alu_op      = 2'b00;
                reg_dest    = 1'b0;
            end
            6'h2B : begin                   // for (I type) register to memory instructions (sw)
                reg_write   = 1'b0;
                mem2reg     = 1'b0;
                branch      = 1'b0;
                mem_write   = 1'b1;
                mem_read    = 1'b0;
                alu_src     = 1'b1;
                alu_op      = 2'b00;
                reg_dest    = 1'bx;
            end
        endcase
    end

endmodule

`endif