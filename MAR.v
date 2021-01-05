//William Taylor
//System Synthesis and Modeling
//Fall 2020
//University of Arkansas
//williamtaylor@ieee.org || wjtaylor@uark.edu
module MAR(
	input [15:0] busOUT,
	input MAR_EN,reset,clk,
	output reg [15:0] MAR_OUT
	   );


always @(posedge reset) 
begin
 if(reset == 1'b1)
  MAR_OUT <= 16'bzzzzzzzzzzzzzzzz; 
end 

always @(posedge MAR_EN or posedge clk) 
begin
 if(MAR_EN == 1)
  MAR_OUT <= busOUT; 
end 
endmodule 
