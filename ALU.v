//William Taylor
//System Synthesis and Modeling
//Fall 2020
//University of Arkansas
//williamtaylor@ieee.org || wjtaylor@uark.edu
module ALU(
	input out_EN,reset,A_in,B_in,
        input [15:0] busIN,			//Bus Input
        input [2:0] select,			//Selection	
	output reg [15:0] busOUT		//Output to Bus    
	);
    	reg [15:0] ALU_Result, A, B;

	always @(*)
	begin
		if (reset == 1) 
			A <= 16'b0000000000000000; 
		else if (A_in) 
			A <= busIN;
	end

	
	always @(*)
	begin
		if (reset == 1) 
			B <= 16'b0000000000000000; 
		else if (B_in) 
			B <= busIN;
	end

    always @(*)
    begin
        case(select)
        3'b000: ALU_Result = A + B; 			//Add
	3'b001: ALU_Result = A - B;			//Subtract
        3'b010: ALU_Result = A & B;			//AND
        3'b011: ALU_Result = A | B;			//OR
        3'b100: ALU_Result = A ^ B;			//XOR
        3'b101: ALU_Result = !A;			//NOT
        3'b110: ALU_Result = ~(A ^ B);			//XNOR
        default: ALU_Result = 16'b0000000000000000; 
        endcase

	if (out_EN == 1)	begin
		busOUT <= ALU_Result; 
		end
	else if (out_EN == 0) begin
		busOUT <= 16'bZZZZZZZZZZZZZZZZ; 
		end
    end
endmodule


