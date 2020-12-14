//ShifterAndALU.v

// select 0 = in0 1 = in1
module mux2to1_3bit(input [2:0] in0, input [2:0] in1, input select, output reg [2:0] muxOut);   // mux whose o/p is fed to barrel shifter
  //WRITE CODE HERE
  
    always @(in0,in1,select)        // executes when any 1 (or more) of these 3 change
        begin
            case(select)
                  1'b0: muxOut = in0;
                  1'b1: muxOut = in1;
            endcase
        end
endmodule



// select 0 = in0 1 = in1
module mux2to1_8bit(input [7:0] in0, input [7:0] in1, input select, output reg [7:0] muxOut);   // Last mux that (gives the output)
   //WRITE CODE HERE
    always @(in0,in1,select)      
        begin
            case(select)
                1'b0: muxOut = in0;         // ALU one
                1'b1: muxOut = in1;         // Barrel Shifter one
            endcase
        end
endmodule


module mux8to1_1bit(input in0, input in1, input in2, input in3, input in4, input in5, input in6, input in7, input[2:0] select,output reg muxOut);
   //WRITE CODE HERE

   // This mux is used in designing the barrel shifter

    always@(in0,in1,in2,in3,in4,in5,in6,in7,select)
        begin
            case(select)
                3'b000: muxOut = in0;
                3'b001: muxOut = in1;
                3'b010: muxOut = in2;
                3'b011: muxOut = in3;
                3'b100: muxOut = in4;
                3'b101: muxOut = in5;
                3'b110: muxOut = in6;
                3'b111: muxOut = in7;
            endcase
        end
endmodule

module barrelshifter(input[2:0] shiftAmt, input[7:0] b, input[2:0] oper, output[7:0] shiftOut);
	   //WRITE CODE HERE
     
       wire [2:0] Aout;
       wire [2:0] Bout;
       wire [2:0] Cout;

       // Aout, Bout, Cout act as select in mux
       wire [7:0] s;
       wire [7:0] r;

       mux2to1_3bit mux2to1_3_call_1(3'b000, oper, shiftAmt[0], Aout);
       mux2to1_3bit mux2to1_3_call_2(3'b000, oper, shiftAmt[1], Bout);
       mux2to1_3bit mux2to1_3_call_3(3'b000, oper, shiftAmt[2], Cout);

       mux8to1_1bit mux8to1_1_call_1(b[0], b[1], b[1], b[1], 1'b0, b[7], 1'b0, 1'b0, Aout, s[0]);
       mux8to1_1bit mux8to1_1_call_2(b[1], b[2], b[2], b[2], b[0], b[0], 1'b0, 1'b0, Aout, s[1]);
       mux8to1_1bit mux8to1_1_call_3(b[2], b[3], b[3], b[3], b[1], b[1], 1'b0, 1'b0, Aout, s[2]);
       mux8to1_1bit mux8to1_1_call_4(b[3], b[4], b[4], b[4], b[2], b[2], 1'b0, 1'b0, Aout, s[3]);
       mux8to1_1bit mux8to1_1_call_5(b[4], b[5], b[5], b[5], b[3], b[3], 1'b0, 1'b0, Aout, s[4]);
       mux8to1_1bit mux8to1_1_call_6(b[5], b[6], b[6], b[6], b[4], b[4], 1'b0, 1'b0, Aout, s[5]);
       mux8to1_1bit mux8to1_1_call_7(b[6], b[7], b[7], b[7], b[5], b[5], 1'b0, 1'b0, Aout, s[6]);
       mux8to1_1bit mux8to1_1_call_8(b[7], b[7], 1'b0, b[0], b[6], b[6], 1'b0, 1'b0, Aout, s[7]);

       mux8to1_1bit mux8to1_1_call1_1(s[0], s[2], s[2], s[2], 1'b0, s[6], 1'b0, 1'b0, Bout, r[0]);
       mux8to1_1bit mux8to1_1_call1_2(s[1], s[3], s[3], s[3], 1'b0, s[7], 1'b0, 1'b0, Bout, r[1]);
       mux8to1_1bit mux8to1_1_call1_3(s[2], s[4], s[4], s[4], s[0], s[0], 1'b0, 1'b0, Bout, r[2]);
       mux8to1_1bit mux8to1_1_call1_4(s[3], s[5], s[5], s[5], s[1], s[1], 1'b0, 1'b0, Bout, r[3]);
       mux8to1_1bit mux8to1_1_call1_5(s[4], s[6], s[6], s[6], s[2], s[2], 1'b0, 1'b0, Bout, r[4]);
       mux8to1_1bit mux8to1_1_call1_6(s[5], s[7], s[7], s[7], s[3], s[3], 1'b0, 1'b0, Bout, r[5]);
       mux8to1_1bit mux8to1_1_call1_7(s[6], s[7], 1'b0, s[0], s[4], s[4], 1'b0, 1'b0, Bout, r[6]);
       mux8to1_1bit mux8to1_1_call1_8(s[7], s[7], 1'b0, s[1], s[5], s[5], 1'b0, 1'b0, Bout, r[7]);

       mux8to1_1bit mux8to1_1_call2_1(r[0], r[4], r[4], r[4], 1'b0, r[4], 1'b0, 1'b0, Cout, shiftOut[0]);
       mux8to1_1bit mux8to1_1_call2_2(r[1], r[5], r[5], r[5], 1'b0, r[5], 1'b0, 1'b0, Cout, shiftOut[1]);
       mux8to1_1bit mux8to1_1_call2_3(r[2], r[6], r[6], r[6], 1'b0, r[6], 1'b0, 1'b0, Cout, shiftOut[2]);
       mux8to1_1bit mux8to1_1_call2_4(r[3], r[7], r[7], r[7], 1'b0, r[7], 1'b0, 1'b0, Cout, shiftOut[3]);
       mux8to1_1bit mux8to1_1_call2_5(r[4], r[7], 1'b0, r[0], r[0], r[0], 1'b0, 1'b0, Cout, shiftOut[4]);
       mux8to1_1bit mux8to1_1_call2_6(r[5], r[7], 1'b0, r[1], r[1], r[1], 1'b0, 1'b0, Cout, shiftOut[5]);
       mux8to1_1bit mux8to1_1_call2_7(r[6], r[7], 1'b0, r[2], r[2], r[2], 1'b0, 1'b0, Cout, shiftOut[6]);
       mux8to1_1bit mux8to1_1_call2_8(r[7], r[7], 1'b0, r[3], r[3], r[3], 1'b0, 1'b0, Cout, shiftOut[7]);

endmodule

// Alu operations are: 00 for alu1, 01 for add, 10 for sub(alu1-alu2) , 11 for AND, 100 for OR and 101 for NOT(alu1)
module alu(input [7:0] aluIn1, input [7:0] aluIn2, input [2:0]aluOp, output reg [7:0] aluOut);
       //WRITE CODE HERE

    always@(aluIn1,aluIn2,aluOp)
        begin
            case(aluOp)
                3'b000:aluOut = aluIn1;
                3'b001:aluOut = aluIn1 + aluIn2;
                3'b010:aluOut = aluIn1 - aluIn2;
                3'b011:aluOut = aluIn1 & aluIn2;
                3'b100:aluOut = aluIn1 | aluIn2;
                3'b101:aluOut = ~ aluIn1;
                default: aluOut=0;
            endcase
        end       

endmodule


module shifterAndALU(input [7:0]inp1, input [7:0] inp2, input [2:0]shiftlmm, input selShiftAmt, input [2:0]oper, input selOut, output [7:0] out);
	   //WRITE CODE HERE

       wire [7:0] shiftOut;
       wire [2:0] shiftAmt;
       wire [7:0] aluOut;

       // barrelshifter part
       mux2to1_3bit mux2to1_3_call(inp2[2:0], shiftlmm, selShiftAmt, shiftAmt); 
       barrelshifter bshifter_call(shiftAmt, inp1, oper, shiftOut);

       // ALU part 
       alu alu_call(inp1, inp2, oper, aluOut);

      // gives the final output
       mux2to1_8bit mux2to1_8_call(aluOut, shiftOut, selOut, out);                    


endmodule

//TestBench ALU
module testbenchALU();
	// Input
	reg [7:0] inp1, inp2;
	reg [2:0] aluOp;
	reg [2:0] shiftlmm;
	reg selShiftAmt, selOut;
	// Output
	wire [7:0] aluOut;

	shifterAndALU shifterAndALU_Test (inp1, inp2, shiftlmm, selShiftAmt, aluOp, selOut, aluOut);

	initial
		begin
			$dumpfile("testALU.vcd");
     	$dumpvars(0,testbenchALU);
			inp1 = 8'd80; //80 in binary is 1010000
			inp2 = 8'd20; //20 in binary is 10100   
			shiftlmm = 3'b010; 
			
			aluOp=3'd0; selOut = 1'b0;// normal output = 80

			#10 aluOp = 3'd0; selOut = 1'b1; selShiftAmt = 1'b1; //No shift output = 80

			#10 aluOp=3'd1; selOut = 1'b0;// normal add	output => 20 + 80 = 100

			#10 aluOp = 3'd1; selOut = 1'b1; selShiftAmt = 1'b1; // arithmetic shift right of 80 by 2 places = 20

			#10 aluOp=3'd2; selOut = 1'b0; // normal sub output => 80 - 20 = 60

			#10 aluOp = 3'd2; selOut = 1'b1; selShiftAmt = 1'b0; // logical shift right of 80 by 4 places = 0

			#10 aluOp=3'd3; selOut = 1'b0;// normal and output => 80 & 20 = 16

			#10 aluOp = 3'd3; selOut = 1'b1; selShiftAmt = 1'b0; // Circular Shift Right of 80 by 4 places = 5

			#10 aluOp=3'd4; selOut = 1'b0;// normal or output => 80 | 20 = 84

			#10 aluOp = 3'd4; selOut = 1'b1; selShiftAmt = 1'b1; // Logical Shift Left of 80 by 2 bits = 64

			#10 aluOp=3'd5; selOut = 1'b0; // normal not of 80 = 175

			#10 aluOp = 3'd5; selOut = 1'b1; selShiftAmt = 1'b0; // Circular left shift of 80 by 4 bits = 5

			#10 inp1=8'd15; inp2=8'd26; aluOp=3'd2; selOut = 1'b0;//sub overflow 
			// (15 - 26) = -11 and its a 8 bit number so, 256-11 = 245 output => 245 (since it is unsigned decimal)

			#10 inp1=8'd150; inp2=8'd150; aluOp=3'd1; selOut = 1'b0;// add overflow
			//(150+150) = 300 and its a 8 bit number so, 300-256 = 44 output=> 44.

			#10 inp1=8'b0000_0000; aluOp=3'd5; selOut = 1'b0;//not overflow
			// not(0) = all 1. Since its a 8 bit number output=>255

			#10 $finish;
		end

endmodule
