//William Taylor
//System Synthesis and Modeling
//Fall 2020
//University of Arkansas
//williamtaylor@ieee.org || wjtaylor@uark.edu
module ID(
	input [15:0] IR_OUT,
	input reset,clk,MFC,
	output reg R0_OUT,R1_OUT,R2_OUT,R3_OUT,R0_EN, R1_EN, R2_EN, R3_EN,PC_OUT,MAR_EN,RW,MEM_EN,MEM_BUS,BUS_MEM,MDR_OUT,A_in,B_in,out_EN,IO_OUT0,IO_OUT1,IO_EN0,IO_EN1,IR_EN,increment,
	output reg [2:0] select,
	output reg [15:0] busOUT
	   );

reg [3:0] OPcode;
reg [5:0] parameterA, parameterB;
reg IF_EN,R_ALU_EN,I_ALU_EN,LOAD_EN,STORE_EN,MOV_EN,MOVI_EN,ID_OUT;
reg [2:0] state, nextstate;
reg [15:0] data;
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110, S7 = 3'b111;

always @(posedge clk or posedge reset) begin
	if (reset)
	begin	
		OPcode 		<= 	4'b0000;
		parameterA	<= 	6'b000000;
		parameterB	<= 	6'b000000;
 		state <= S0;
		IF_EN <= 1;
     	   	R0_OUT <= 0;
		R1_OUT <= 0;
		R2_OUT <= 0;
		R3_OUT <= 0;
		R0_EN <= 0;
		R1_EN <= 0;
		R2_EN <= 0;
		R3_EN <= 0;
		PC_OUT <= 0;
		MAR_EN <= 0;
		RW <= 0;
		MEM_EN <= 0;
		MEM_BUS <= 0;
		BUS_MEM <= 0;
		MDR_OUT <= 0;
		IR_EN <= 0;
		A_in <= 0;
		B_in <= 0;
		out_EN <= 0;
		IO_OUT0 <= 0;
		IO_EN0 <= 0;
		IO_OUT1 <= 0;
		IO_EN1 <= 0;
		IR_EN <= 0;
		increment <= 0;
		busOUT <= 16'bZZZZZZZZZZZZZZZZ; 
		select <= 3'bzzz;
	end
	else begin
		state 		<= 	nextstate;
		OPcode 		<= 	IR_OUT [15:12];
		parameterA	<= 	IR_OUT [11:6];
		parameterB	<= 	IR_OUT [5:0];
	end
end

always @(posedge clk or posedge reset) 
if (reset)
state <= S0;
else if (IF_EN)
begin
 	case(state)
 		S0:	begin
				nextstate <= S1;
				PC_OUT <= 1;
				MAR_EN <= 1;
			end

 		S1: 	begin
				nextstate <= S2;
				MAR_EN <= 0;
				PC_OUT <= 0;
				RW <= 1;
				MEM_EN <= 1;
				if (MFC == 1)
 					nextstate <= S2;
				else
					nextstate <= S1;
 			end

		S2: 	begin
				nextstate <= S3;
				MEM_EN <= 0;
				MEM_BUS <= 1;
				MDR_OUT <= 1;
				IR_EN <= 1;
				increment <= 1;
				
 			end

		S3: 	begin
				nextstate <= S4;
				IR_EN <= 0;
				MDR_OUT <= 0;
				MEM_BUS <= 0;
				increment <= 0;
				
				
 			end

		S4: 	begin
				nextstate <= S0;
				state <= S0;
				IF_EN <= 0;
				if(OPcode == 4'b0000)
					MOV_EN <= 1;
				else if(OPcode == 4'b0001) 
					R_ALU_EN <= 1;
				else if(OPcode == 4'b0010) 
					I_ALU_EN <= 1;
				else if(OPcode == 4'b0011) 
					R_ALU_EN <= 1;
				else if(OPcode == 4'b0100)
					I_ALU_EN <= 1;
				else if(OPcode == 4'b0101) 
					R_ALU_EN <= 1;
				else if(OPcode == 4'b0110)
					R_ALU_EN <= 1;
				else if(OPcode == 4'b0111)
					R_ALU_EN <= 1;
				else if(OPcode == 4'b1000) 
					R_ALU_EN <= 1;
				else if(OPcode == 4'b1001)
					R_ALU_EN <= 1;
				else if(OPcode == 4'b1010)
					MOVI_EN <= 1;
				else if(OPcode == 4'b1011) 
					LOAD_EN <= 1;
				else if(OPcode == 4'b1100)
					STORE_EN <= 1;
 			end

 		default:
		begin
		end
 	endcase
end

always @(posedge clk or posedge reset) 
if (reset)begin
	state <= S0;
	nextstate <= S0;
end
else if (R_ALU_EN)
begin
 	case(state)
 		S0:	begin
				nextstate <= S1;
				if (parameterA == 6'b000000)
					R0_OUT <= 1;
				if (parameterA == 6'b000001)
					R1_OUT <= 1;
				if (parameterA == 6'b000010)
					R2_OUT <= 1;
				if (parameterA == 6'b000011)
					R3_OUT <= 1;
				if (parameterA == 6'b000100)
					IO_OUT0 <= 1;
				A_in <= 1;
			end

 		S1: 	begin
				nextstate <= S2;
				if (parameterA == 6'b000000)
					R0_OUT <= 0;
				if (parameterA == 6'b000001)
					R1_OUT <= 0;
				if (parameterA == 6'b000010)
					R2_OUT <= 0;
				if (parameterA == 6'b000011)
					R3_OUT <= 0;
				if (parameterA == 6'b000100)
					IO_OUT0 <= 0;
				A_in <= 0;
				
 			end

		S2: 	begin
				nextstate <= S3;
				if (parameterB == 6'b000000)
					R0_OUT <= 1;
				if (parameterB == 6'b000001)
					R1_OUT <= 1;
				if (parameterB == 6'b000010)
					R2_OUT <= 1;
				if (parameterB == 6'b000011)
					R3_OUT <= 1;
				if (parameterB == 6'b000100)
					IO_OUT0 <= 1;
				B_in <= 1;
 			end

		S3: 	begin
				nextstate <= S4;
				if (parameterB == 6'b000000)
					R0_OUT <= 0;
				if (parameterB == 6'b000001)
					R1_OUT <= 0;
				if (parameterB == 6'b000010)
					R2_OUT <= 0;
				if (parameterB == 6'b000011)
					R3_OUT <= 0;
				if (parameterB == 6'b000100)
					IO_OUT0 <= 0;
				B_in <= 0;
 			end

		S4: 	begin
				nextstate <= S5;
				if (OPcode == 4'b0001)
					select <= 3'b000;
				if (OPcode == 4'b0011)
					select <= 3'b001;
				if (OPcode == 4'b0110)
					select <= 3'b010;
				if (OPcode == 4'b0111)
					select <= 3'b011;
				if (OPcode == 4'b1000)
					select <= 3'b100;
				if (OPcode == 4'b1001)
					select <= 3'b110;
				if (OPcode == 4'b0101)
					select <= 3'b101;
 			end


		S5:	begin
				nextstate <= S6;
				out_EN <= 1;
				if (parameterA == 6'b000000)
					R0_EN <= 1;
				if (parameterA == 6'b000001)
					R1_EN <= 1;
				if (parameterA == 6'b000010)
					R2_EN <= 1;
				if (parameterA == 6'b000011)
					R3_EN <= 1;
				if (parameterA == 6'b000100)
					IO_EN0 <= 1;
			end
		S6: 	begin
				nextstate <= S7;
				out_EN <= 0;
				if (parameterA == 6'b000000)
					R0_EN <= 0;
				if (parameterA == 6'b000001)
					R1_EN <= 0;
				if (parameterA == 6'b000010)
					R2_EN <= 0;
				if (parameterA == 6'b000011)
					R3_EN <= 0;
				if (parameterA == 6'b000100)
					IO_EN0 <= 0;
			end

		S7:	begin
				state <= S0;
				nextstate <= S0;
				IF_EN <= 1;
				R_ALU_EN <= 0;
 			end
 		default:
		begin
		end
 	endcase
end

always @(posedge clk or posedge reset) 
if (reset)begin
	state <= S0;
	nextstate <= S0;
end
else if (I_ALU_EN)
begin
 	case(state)
 		S0:	begin
				nextstate <= S1;
				if (parameterA == 6'b000000)
					R0_OUT <= 1;
				if (parameterA == 6'b000001)
					R1_OUT <= 1;
				if (parameterA == 6'b000010)
					R2_OUT <= 1;
				if (parameterA == 6'b000011)
					R3_OUT <= 1;
				A_in <= 1;
			end

 		S1: 	begin
				nextstate <= S2;
				if (parameterA == 6'b000000)
					R0_OUT <= 0;
				if (parameterA == 6'b000001)
					R1_OUT <= 0;
				if (parameterA == 6'b000010)
					R2_OUT <= 0;
				if (parameterA == 6'b000011)
					R3_OUT <= 0;
				A_in <= 0;
				
 			end

		S2: 	begin
				nextstate <= S3;
				ID_OUT <= 1;
				data <= parameterB;
				B_in <= 1;
 			end

		S3: 	begin
				nextstate <= S4;
				B_in <= 0;
				ID_OUT <= 0;
 			end

		S4: 	begin
				nextstate <= S5;
				if (OPcode == 4'b0010)
					select <= 3'b000;
				if (OPcode == 4'b0100)
					select <= 3'b001;
 			end


		S5:	begin
				nextstate <= S6;
				out_EN <= 1;
				if (parameterA == 6'b000000)
					R0_EN <= 1;
				if (parameterA == 6'b000001)
					R1_EN <= 1;
				if (parameterA == 6'b000010)
					R2_EN <= 1;
				if (parameterA == 6'b000011)
					R3_EN <= 1;
				if (parameterA == 6'b000100)
					IO_EN0 <= 1;
			end
		S6: 	begin
				if (parameterA == 6'b000000)
					R0_EN <= 0;
				if (parameterA == 6'b000001)
					R1_EN <= 0;
				if (parameterA == 6'b000010)
					R2_EN <= 0;
				if (parameterA == 6'b000011)
					R3_EN <= 0;
				if (parameterA == 6'b000100)
					IO_EN0 <= 0;
				out_EN <= 0;
				select <= 3'bzzz;
				nextstate <= S7;
 			end
		S7:	begin
				nextstate <= S0;
				state <= S0;
				IF_EN <= 1;
				I_ALU_EN <= 0;
			end
 		default:
		begin
		end
 	endcase
end

always @(posedge clk or posedge reset) 
if (reset)begin
	state <= S0;
	nextstate <= S0;
end
else if (LOAD_EN)
begin
 	case(state)
 		S0:	begin
				RW <= 1;
				MAR_EN <= 1;
				nextstate <= S1;
				if (parameterA == 6'b000000)
					R0_OUT <= 1;
				if (parameterA == 6'b000001)
					R1_OUT <= 1;
				if (parameterA == 6'b000010)
					R2_OUT <= 1;
				if (parameterA == 6'b000011)
					R3_OUT <= 1;
			end

 		S1: 	begin
				nextstate <= S2;
				MAR_EN <= 0;
				if (parameterA == 6'b000000)
					R0_OUT <= 0;
				if (parameterA == 6'b000001)
					R1_OUT <= 0;
				if (parameterA == 6'b000010)
					R2_OUT <= 0;
				if (parameterA == 6'b000011)
					R3_OUT <= 0;
				MEM_EN <= 1;
				if (OPcode == 1011) begin
					RW <= 0;
					end
 			end

		S2: 	begin
				if (MFC == 1)
 					nextstate <= S3;
				else
					nextstate <= S2;
 			end

		S3: 	begin
				nextstate <= S4;
				MDR_OUT <= 1;
				MEM_BUS <= 1;
				if (parameterB == 6'b000000)
					R0_EN <= 1;
				if (parameterB == 6'b000001)
					R1_EN <= 1;
				if (parameterB == 6'b000010)
					R2_EN <= 1;
				if (parameterB == 6'b000011)
					R3_EN <= 1;
 			end

		S4: 	begin
				nextstate <= S5;
				MDR_OUT <= 0;
				MEM_BUS <= 0;
				if (parameterB == 6'b000000)
					R0_EN <= 0;
				if (parameterB == 6'b000001)
					R1_EN <= 0;
				if (parameterB == 6'b000010)
					R2_EN <= 0;
				if (parameterB == 6'b000011)
					R3_EN <= 0;
 			end

		S5: 	begin
				nextstate <= S0;
				state <= S0;
				IF_EN <= 1;
				LOAD_EN <= 0;
			end
 		default:
		begin
		end
 	endcase
end

always @(posedge clk or posedge reset) 
if (reset)begin
	state <= S0;
	nextstate <= S0;
end
else if (STORE_EN)
begin
 	case(state)
 		S0:	begin
				nextstate <= S1;
				if (parameterA == 6'b000000)
					R0_OUT <= 1;
				if (parameterA == 6'b000001)
					R1_OUT <= 1;
				if (parameterA == 6'b000010)
					R2_OUT <= 1;
				if (parameterA == 6'b000011)
					R3_OUT <= 1;
				if (parameterA == 6'b000100)
					IO_OUT0 <= 1;
				BUS_MEM <= 1;
				RW <= 0;
				
			end

 		S1: 	begin
				nextstate <= S2;
				if (parameterA == 6'b000000)
					R0_OUT <= 0;
				if (parameterA == 6'b000001)
					R1_OUT <= 0;
				if (parameterA == 6'b000010)
					R2_OUT <= 0;
				if (parameterA == 6'b000011)
					R3_OUT <= 0;
				if (parameterA == 6'b000100)
					IO_OUT0 <= 0;
				BUS_MEM <= 0;
				MEM_EN <= 1;
 			end

		S2: 	begin
				if (MFC == 1)begin
					nextstate <= S3;
					MEM_EN <= 0;
					end
				else begin
					nextstate <= S2;
					end
 			end

		S3:	begin
				nextstate <= S4;
				data = 16'b1111111111111111;
				ID_OUT <= 1;
				if (parameterB == 6'b000000)
					R0_EN <= 1;
				if (parameterB == 6'b000001)
					R1_EN <= 1;
				if (parameterB == 6'b000010)
					R2_EN <= 1;
				if (parameterB == 6'b000011)
					R3_EN <= 1;
				if (parameterB == 6'b000100)
					IO_EN0 <= 1;
			end


		S4:	begin
				nextstate <= S5;
				ID_OUT <= 0;
				if (parameterB == 6'b000000)
					R0_EN <= 0;
				if (parameterB == 6'b000001)
					R1_EN <= 0;
				if (parameterB == 6'b000010)
					R2_EN <= 0;
				if (parameterB == 6'b000011)
					R3_EN <= 0;
				if (parameterB == 6'b000100)
					IO_EN0 <= 0;
			end

		S5: 	begin
				nextstate <= S0;
				state <= S0;
				IF_EN <= 1;
				STORE_EN <= 0;
 			end
 		default:
		begin
		end
 	endcase
end

always @(posedge clk or posedge reset) 
if (reset)begin
	state <= S0;
	nextstate <= S0;
end
else if (MOV_EN)
begin
 	case(state)
 		S0:	begin
				nextstate <= S1;
				if (parameterB == 6'b000000)
					R0_OUT <= 1;
				if (parameterB == 6'b000001)
					R1_OUT <= 1;
				if (parameterB == 6'b000010)
					R2_OUT <= 1;
				if (parameterB == 6'b000011)
					R3_OUT <= 1;

				if (parameterA == 6'b000000)
					R0_EN <= 1;
				if (parameterA == 6'b000001)
					R1_EN <= 1;
				if (parameterA == 6'b000010)
					R2_EN <= 1;
				if (parameterA == 6'b000011)
					R3_EN <= 1;
				
			end

		S1: 	begin
				nextstate <= S2;
				if (parameterB == 6'b000000)
					R0_OUT <= 0;
				if (parameterB == 6'b000001)
					R1_OUT <= 0;
				if (parameterB == 6'b000010)
					R2_OUT <= 0;
				if (parameterB == 6'b000011)
					R3_OUT <= 0;

				if (parameterA == 6'b000000)
					R0_EN <= 0;
				if (parameterA == 6'b000001)
					R1_EN <= 0;
				if (parameterA == 6'b000010)
					R2_EN <= 0;
				if (parameterA == 6'b000011)
					R3_EN <= 0;
 			end



		S2: 	begin
				nextstate <= S0;
				state <= S0;
				IF_EN <= 1;
				MOV_EN <= 0;
 			end
 		default:
		begin
		end
 	endcase
end	

always @(posedge clk or posedge reset) 
if (reset)begin
	state <= S0;
	nextstate <= S0;
end
else if (MOVI_EN)
begin
 	case(state)
		S0: 	begin
				nextstate <= S1;
				if (parameterA == 6'b000000)
					R0_EN <= 1;
				if (parameterA == 6'b000001)
					R1_EN <= 1;
				if (parameterA == 6'b000010)
					R2_EN <= 1;
				if (parameterA == 6'b000011)
					R3_EN <= 1;
				if (parameterA == 6'b000100)
					IO_EN0 <= 1;
				data <= parameterB;
				ID_OUT <= 1;
 			end

		S1: 	begin
				nextstate <= S2;
				ID_OUT <= 0;
				if (parameterA == 6'b000000)
					R0_EN <= 0;
				if (parameterA == 6'b000001)
					R1_EN <= 0;
				if (parameterA == 6'b000010)
					R2_EN <= 0;
				if (parameterA == 6'b000011)
					R3_EN <= 0;
				if (parameterA == 6'b000100)
					IO_EN0 <= 0;
 			end

		S2: 	begin
				nextstate <= S0;
				state <= S0;
				IF_EN <= 1;
				MOVI_EN <= 0;
 			end
 		default:
		begin
		end
 	endcase
end				

always @ (posedge ID_OUT or posedge clk)
begin
	if (ID_OUT == 1)begin
		busOUT = data; 
		end
	else if (ID_OUT == 0) begin
		busOUT = 16'bZZZZZZZZZZZZZZZZ; 
		end
end
endmodule 

