// NO CHANGES NEED TO BE MADE TO THIS MODULE

`ifndef __alu_ctrl__
`define __alu_ctrl__ defined

module alu_control (
    input [1:0] alu_op,
    input [5:0] funct,
    output reg [3:0] operation
);

    always @(*) begin
        if (alu_op == 2'b00)                // for addi, lw and sw (addition of the sign extended immediate number)
            operation = 4'h2;
        else if (alu_op[0] == 1'b1)         // for beq (subtraction of regs to check equality)
            operation = 4'h6;
        else if (alu_op[1] == 1'b1)
            case (funct[3:0])
                4'h0 : operation = 4'h2;    // add
                4'h2 : operation = 4'h6;    // sub
                4'h4 : operation = 4'h0;    // and
                4'h5 : operation = 4'h1;    // or
                4'h7 : operation = 4'hc;    // or
                4'ha : operation = 4'h7;    // slt
            endcase
    end

endmodule

`endif