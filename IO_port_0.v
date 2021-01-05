//William Taylor
//System Synthesis and Modeling
//Fall 2020
//University of Arkansas
//williamtaylor@ieee.org || wjtaylor@uark.edu
module IO_0(
	input [15:0] busIN,
	input IO_EN0,reset,IO_OUT0,clk,
	output reg [15:0] busOUT
	   );
reg [15:0] Q;
always @(posedge IO_EN0 or posedge reset or posedge clk) 
begin
 if(reset == 1'b1)
  Q <= 16'bzzzzzzzzzzzzzzzz; 
 else if(IO_EN0 == 1)
  Q <= busIN; 
end 

always @ (posedge IO_OUT0 or posedge clk)
if (IO_OUT0 == 1)begin
	busOUT <= Q; 
	end
else if (IO_OUT0 == 0) begin
	busOUT <= 16'bZZZZZZZZZZZZZZZZ; 
	end
endmodule 
