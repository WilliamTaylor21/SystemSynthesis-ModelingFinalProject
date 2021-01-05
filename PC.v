//William Taylor
//System Synthesis and Modeling
//Fall 2020
//University of Arkansas
//williamtaylor@ieee.org || wjtaylor@uark.edu
module PC(
	input reset,PC_OUT,clk,increment,
	output reg [15:0] busOUT
	   );
reg [15:0] instruction = 16'bzzzzzzzzzzzzzzzz;
always @(posedge reset) 
begin
	if (reset == 1)begin
	instruction = 16'b0000000000000000;
	end
end 

always @(posedge increment)begin
instruction = instruction + 1'b1;
end

always @ (posedge PC_OUT or posedge clk)
if (PC_OUT == 1)begin
	busOUT = instruction; 
	end
else if (PC_OUT == 0) begin
	busOUT = 16'bZZZZZZZZZZZZZZZZ; 
	end
endmodule 
