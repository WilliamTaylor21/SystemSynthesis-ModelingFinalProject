//William Taylor
//System Synthesis and Modeling
//Fall 2020
//University of Arkansas
//williamtaylor@ieee.org || wjtaylor@uark.edu

module IR(
	input [15:0] busOUT,
	input IR_EN,reset,clk,
	output reg [15:0] IR_OUT
	   );
always @(posedge reset) 
begin
 if(reset == 1'b1)
  IR_OUT <= 16'bzzzzzzzzzzzzzzzz; 
end 

always @(posedge IR_EN or posedge clk) 
begin
if (IR_EN == 1)
  IR_OUT <= busOUT; 
end 

endmodule
