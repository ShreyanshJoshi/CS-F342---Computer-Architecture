// NO CHANGES NEED TO BE MADE TO THIS MODULE

`ifndef __alu__
`define __alu__ defined

module alu (
    input [31:0] in0,
    input [31:0] in1,
    input [3:0] alu_op,
    output reg [31:0] alu_res,
    output zero
);

    always @ (*) begin
        case (alu_op)
            4'b0000 : alu_res = in0 & in1;
            4'b0001 : alu_res = in0 | in1;
            4'b0010 : alu_res = in0 + in1;
            4'b0110 : alu_res = in0 - in1;
            4'b0111 : alu_res = {31'b0, (in0 < in1)};
            4'b1100 : alu_res = ~(in0 | in1);
        endcase
    end

    assign zero = (alu_res == 32'h00000000);

endmodule

`endif