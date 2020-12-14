`include "alu.v"
`include "control.v"
`include "dff.v"
`include "memory.v"
`include "mux.v"
`include "register_file.v"
`include "registers.v"
`include "sign_ext.v"

module multi_cycle (input clk, input reset, output [31:0] result);
    
    // Write your code here
    // make sure that the im module is instantiated as "instruction memory"   

    wire[31:0] inPC, outPC, out0, out1, IMOut, IROut, MDROut, writeData, regFileOut0, regFileOut1, AOut, BOut, aluIn1, aluIn2, aluOut0,
    aluOut1, signExt, hiOut, loOut, jump_addr;

	wire[4:0] im_in, rd;
	wire[1:0] aluSrcB, aluOp, memToReg, pcSrc;
	wire PCregWrite, branch, zero, pcWrite, branch_or_zero, IorD, memRead, IRWrite, regWrite, regDest, aluSrcA, hiWrite, loWrite;
 
	assign jump_addr[31:28] = outPC[31:28];
	assign jump_addr[27:0] = IROut[27:0]<<2;

	mux4to1 #(32) pc_m1 (out0, jump_addr, aluOut0, 32'd0, pcSrc, inPC);

	and pc_g1 (branch_or_zero, branch, zero);
	or pc_g2 (PCregWrite, pcWrite, branch_or_zero);

	intermediate_reg #(32) PC (clk, reset, PCregWrite, inPC, outPC);		// program counter
 
	mux2to1 #(5) im_m1 (outPC[6:2], out0[6:2], IorD, im_in);				// mux just beside PC
	im #(32, 5) instruction_memory (clk, reset, im_in, memRead, IMOut);
 	
 	// Next 2 registers are non-architectural elements in multi-cycle, used to store intermediate values
	intermediate_reg #(32) IR (clk, reset, IRWrite, IMOut, IROut);
	intermediate_reg #(32) MDR (clk, reset, 1'b1, IMOut, MDROut);
 
	mux2to1 #(5) regFile_m1 (IROut[20:16], IROut[15:11], regDest, rd);
	mux4to1 #(32) regFile_m2 (MDROut, hiOut, out0, 32'd0, memToReg, writeData);

	register_file regFile (clk, reset, regWrite, IROut[25:21], IROut[20:16], rd, writeData, regFileOut0, regFileOut1);
 
	control_circuit ctrlCkt (clk, reset, IROut[31:26], IROut[5:0], IorD, memRead,		// CU
		IRWrite, regDest, regWrite, aluSrcA, aluSrcB, aluOp, hiWrite, loWrite,
		memToReg, pcSrc, pcWrite, branch);
 
	intermediate_reg #(32) A (clk, reset, 1'b1, regFileOut0, AOut);
	intermediate_reg #(32) B (clk, reset, 1'b1, regFileOut1, BOut);
 
	sign_ext #(16,32) alu_s1 (IROut[15:0], signExt);

	// Next design, muxes for ALU followed by ALU itself
	mux2to1 #(32) alu_m1 (outPC, AOut, aluSrcA, aluIn1);
	mux4to1 #(32) alu_m2 (BOut, 32'd4, signExt, signExt<<2, aluSrcB, aluIn2);
	alu ALU (aluIn1, aluIn2, aluOp, aluOut0, aluOut1, zero);
 
	intermediate_reg #(32) Out0 (clk, reset, 1'b1, aluOut0, out0);
	intermediate_reg #(32) Out1 (clk, reset, 1'b1, aluOut1, out1);
 
	assign result = out0;
 
	intermediate_reg #(32) Lo (clk, reset, loWrite, out0, loOut);
	intermediate_reg #(32) Hi (clk, reset, hiWrite, out1, hiOut);
        
endmodule