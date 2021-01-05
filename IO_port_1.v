//William Taylor
//System Synthesis and Modeling
//Fall 2020
//University of Arkansas
//williamtaylor@ieee.org || wjtaylor@uark.edu
module IO_1(
	input [15:0] busIN,
	input IO_EN1,reset,IO_OUT1,
	output reg [15:0] busOUT,
	output reg [15:0] exit
	   );
reg [15:0] Q;
always @(posedge IO_EN1 or posedge reset) 
begin
 	if(reset == 1'b1)begin
  	Q <= 16'b0000000000000000; 
  	exit <= 16'b0000000000000000; 
	end
 else 
 begin
  Q <= busIN; 
  exit <= busIN;
 end
end 

always @ (*)
if (IO_OUT1 == 1)begin
	busOUT = Q; 
	end
else if (IO_OUT1 == 0) begin
	busOUT = 16'bZZZZZZZZZZZZZZZZ; 
	end
endmodule 
