//William Taylor
//System Synthesis and Modeling
//Fall 2020
//University of Arkansas
//williamtaylor@ieee.org || wjtaylor@uark.edu
module MDR(
	input [15:0] busIN, Dataout,
	input MEM_BUS,BUS_MEM, reset,MDR_OUT,clk,
	output reg [15:0] datain,
	output reg [15:0] busOUT
	   );

reg [15:0] Q;
always @(posedge BUS_MEM or posedge reset or posedge clk) 
begin
 if(reset == 1'b1)
  datain <= 16'bzzzzzzzzzzzzzzzz; 
 else if(BUS_MEM == 1)
  datain <= busIN; 
end 

always @(posedge MEM_BUS or posedge reset) 
begin
 if(reset == 1'b1)
  Q <= 16'b0000000000000000; 
 else 
  Q <= Dataout; 
end 

always @ (*)
if (MDR_OUT == 1)	begin
	busOUT = Q; 
	end
else if (MDR_OUT == 0) begin
	busOUT = 16'bZZZZZZZZZZZZZZZZ; 
	end
endmodule
