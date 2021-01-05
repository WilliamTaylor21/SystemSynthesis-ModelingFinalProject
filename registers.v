//William Taylor
//System Synthesis and Modeling
//Fall 2020
//University of Arkansas
//williamtaylor@ieee.org || wjtaylor@uark.edu
module R0(
	input [15:0] busIN,
	input R0_EN,reset,R0_OUT,clk,
	output reg [15:0] busOUT
	   );
reg [15:0] Q;
always @(posedge R0_EN or posedge reset or posedge clk) 
begin
 if(reset == 1'b1)
  Q = 16'b0000000000000000; 
 else if (R0_EN == 1)
  Q = busIN; 
end 

always @ (posedge clk or posedge R0_OUT)
if (R0_OUT == 1)begin
	busOUT = Q; 
	end
else if (R0_OUT == 0) begin
	busOUT = 16'bZZZZZZZZZZZZZZZZ; 
	end
endmodule 

module R1(
	input [15:0] busIN,
	input R1_EN,reset,R1_OUT,clk,
	output reg [15:0] busOUT
	   );
reg [15:0] Q;
always @(posedge R1_EN or posedge reset or posedge clk) 
begin
 if(reset == 1'b1)
  Q <= 16'b0000000000000000; 
 else if (R1_EN)
  Q <= busIN; 
end 

always @ (posedge clk or posedge R1_OUT)
if (R1_OUT == 1)begin
	busOUT = Q; 
	end
else if (R1_OUT == 0) begin
	busOUT = 16'bZZZZZZZZZZZZZZZZ; 
	end
endmodule 

module R2(
	input [15:0] busIN,
	input R2_EN,reset,R2_OUT,clk,
	output reg [15:0] busOUT
	   );
reg [15:0] Q;
always @(posedge R2_EN or posedge reset or posedge clk) 
begin
 if(reset == 1'b1)
  Q <= 16'b0000000000000000; 
 else if (R2_EN)
  Q <= busIN; 
end 

always @ (posedge clk or posedge R2_OUT)
if (R2_OUT == 1)begin
	busOUT = Q; 
	end
else if (R2_OUT == 0) begin
	busOUT = 16'bZZZZZZZZZZZZZZZZ; 
	end
endmodule 

module R3(
	input [15:0] busIN,
	input R3_EN,reset,R3_OUT,clk,
	output reg [15:0] busOUT
	   );
reg [15:0] Q;
always @(posedge R3_EN or posedge reset or posedge clk) 
begin
 if(reset == 1'b1)
  Q <= 16'b0000000000000000; 
 else if (R3_EN)
  Q <= busIN; 
end 

always @ (posedge clk or posedge R3_OUT)
if (R3_OUT == 1)begin
	busOUT = Q; 
	end
else if (R3_OUT == 0) begin
	busOUT = 16'bZZZZZZZZZZZZZZZZ; 
	end
endmodule 

