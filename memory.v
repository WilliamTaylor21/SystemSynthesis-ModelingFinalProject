//William Taylor
//System Synthesis and Modeling
//Fall 2020
//University of Arkansas
//williamtaylor@ieee.org || wjtaylor@uark.edu
module mainmemory(Dataout, MFC, MEM_EN, MAR_OUT,
datain, RW,reset);
input MEM_EN, RW,reset;
input[15:0] MAR_OUT, datain;
output [15:0] Dataout;
output MFC;

reg [15:0] Dataout, memorycell;
reg MFC;

always@(posedge reset)
begin
Dataout = 16'bZZZZZZZZZZZZZZZZ;
end

always@(posedge MEM_EN)
begin
	if(RW==1) begin
		case(MAR_OUT)
			16'b0000000000000000: Dataout = 16'b1010000000111010;
			16'b0000000000000001: Dataout = 16'b0100000000001001;
			16'b0000000000000010: Dataout = 16'b1010000100010111;
			16'b0000000000000011: Dataout = 16'b0110000000000010;
			16'b0000000000000100: Dataout = 16'b1000000100000000;
			16'b0000000000000101: Dataout = 16'b0101000000000000;
			16'b0000000000000110: Dataout = 16'b1100000100000000;
			16'b0000000000000111: Dataout = 16'b1011000000000001;
			16'b1111111111111111: Dataout = memorycell;
			default: Dataout = 16'bzzzzzzzzzzzzzzzz;
		endcase
		#5 MFC = 1;
		end
	else 
		begin
		memorycell = datain;
		#5 MFC = 1;
		end
end

always@(negedge MEM_EN)
MFC = 0;
endmodule
