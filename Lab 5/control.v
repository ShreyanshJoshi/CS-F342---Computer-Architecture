module control_circuit (input clk, input reset, input [5:0] opcode, input [5:0] funct, 
                        output reg IorD, output reg memRead, output reg IRWrite, output reg regDest, output reg regWrite,
                        output reg aluSrcA, output reg [1:0] aluSrcB, output reg [1:0] aluOp, output reg hiWrite,
                        output reg loWrite, output reg [1:0] memToReg, output reg [1:0] pcSrc, output reg pcWrite,
                        output reg branch );
    
     // Write your code here
     
    reg [3:0] state;
    reg [3:0] nextState;

    // state must update on every negedge of clk. Need to find state in terms of opcode and func registers.
    // the outputs then are assigned as per the value of state

    always@(negedge clk)
    begin
        case(reset)
            1'b0: state = nextState;
            1'b1: state = 4'd0;
        endcase
    end

    always@(opcode,funct,state)
    begin     
        case(state)
            4'd0: begin IorD=1'b0; memRead=1'b0; IRWrite=1'b0; regDest=1'b0; regWrite=1'b0; aluSrcA=1'b0; aluSrcB=2'b00; aluOp=2'b00;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b00; pcSrc=2'b00; pcWrite=1'b0; branch=1'b0; 

                nextState = 4'd1;
            end

            4'd1: begin IorD=1'b0; memRead=1'b1; IRWrite=1'b1; regDest=1'b0; regWrite=1'b0; aluSrcA=1'b0; aluSrcB=2'b01; aluOp=2'b00;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b00; pcSrc=2'b10; pcWrite=1'b1; branch=1'b0; 

                nextState = 4'd2;
            end

            4'd2: begin IorD=1'b0; memRead=1'b0; IRWrite=1'b0; regDest=1'b0; regWrite=1'b0; aluSrcA=1'b0; aluSrcB=2'b11; aluOp=2'b00;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b00; pcSrc=2'b00; pcWrite=1'b0; branch=1'b0; 

                case(opcode)
                    6'b 011000: nextState = 4'd4;
                    6'b 010000: nextState = 4'd5;
                    6'b 000100: nextState = 4'd8;
                    6'b 001000: nextState = 4'd3;
                    6'b 100011: nextState = 4'd6;
                    6'b 000010: nextState = 4'd7;
                endcase
            end

            4'd3: begin IorD=1'b0; memRead=1'b0; IRWrite=1'b0; regDest=1'b0; regWrite=1'b0; aluSrcA=1'b1; aluSrcB=2'b10; aluOp=2'b00;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b00; pcSrc=2'b00; pcWrite=1'b0; branch=1'b0; 

                nextState = 4'd9;
            end

            4'd4: begin IorD=1'b0; memRead=1'b0; IRWrite=1'b0; regDest=1'b0; regWrite=1'b0; aluSrcA=1'b1; aluSrcB=2'b00; aluOp=2'b10;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b00; pcSrc=2'b00; pcWrite=1'b0; branch=1'b0;

                nextState = 4'd10;
            end

            4'd5: begin IorD=1'b0; memRead=1'b0; IRWrite=1'b0; regDest=1'b1; regWrite=1'b1; aluSrcA=1'b0; aluSrcB=2'b00; aluOp=2'b00;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b01; pcSrc=2'b00; pcWrite=1'b0; branch=1'b0;

                nextState = 4'd1;
            end

            4'd6: begin IorD=1'b0; memRead=1'b0; IRWrite=1'b0; regDest=1'b0; regWrite=1'b0; aluSrcA=1'b1; aluSrcB=2'b10; aluOp=2'b00;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b00; pcSrc=2'b00; pcWrite=1'b0; branch=1'b0;

                nextState = 4'd11;
            end

            4'd7: begin IorD=1'b0; memRead=1'b0; IRWrite=1'b0; regDest=1'b0; regWrite=1'b0; aluSrcA=1'b0; aluSrcB=2'b00; aluOp=2'b00;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b00; pcSrc=2'b01; pcWrite=1'b1; branch=1'b0;

                nextState = 4'd1;
            end

            4'd8: begin IorD=1'b0; memRead=1'b0; IRWrite=1'b0; regDest=1'b0; regWrite=1'b0; aluSrcA=1'b1; aluSrcB=2'b00; aluOp=2'b01;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b00; pcSrc=2'b00; pcWrite=1'b0; branch=1'b1;

                nextState = 4'd1;
            end

            4'd9: begin IorD=1'b0; memRead=1'b0; IRWrite=1'b0; regDest=1'b0; regWrite=1'b1; aluSrcA=1'b0; aluSrcB=2'b00; aluOp=2'b00;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b10; pcSrc=2'b00; pcWrite=1'b0; branch=1'b0;

                nextState = 4'd1;
            end

            4'd10: begin IorD=1'b0; memRead=1'b0; IRWrite=1'b0; regDest=1'b0; regWrite=1'b0; aluSrcA=1'b0; aluSrcB=2'b00; aluOp=2'b00;
                hiWrite=1'b1; loWrite=1'b1; memToReg=2'b00; pcSrc=2'b00; pcWrite=1'b0; branch=1'b0;

                nextState = 4'd1;
            end

            4'd11: begin IorD=1'b1; memRead=1'b1; IRWrite=1'b0; regDest=1'b0; regWrite=1'b0; aluSrcA=1'b0; aluSrcB=2'b00; aluOp=2'b00;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b00; pcSrc=2'b00; pcWrite=1'b0; branch=1'b0;

                nextState = 4'd12;
            end

            4'd12: begin IorD=1'b0; memRead=1'b0; IRWrite=1'b0; regDest=1'b0; regWrite=1'b1; aluSrcA=1'b0; aluSrcB=2'b00; aluOp=2'b00;
                hiWrite=1'b0; loWrite=1'b0; memToReg=2'b00; pcSrc=2'b00; pcWrite=1'b0; branch=1'b0;

                nextState = 4'd1;
            end
        endcase 
    end
endmodule