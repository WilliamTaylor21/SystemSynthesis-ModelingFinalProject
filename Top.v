//William Taylor
//System Synthesis and Modeling
//Fall 2020
//University of Arkansas
//williamtaylor@ieee.org || wjtaylor@uark.edu
module aaaDesign(reset,clk);

wire[15:0]IR_OUT,busOUT,MAR_OUT,datain,Dataout;
wire[2:0] select;
wire R0_OUT,R1_OUT,R2_OUT,R3_OUT,R0_EN, R1_EN, R2_EN, R3_EN,PC_OUT,MAR_EN,RW,MEM_EN,MFC,MEM_BUS,BUS_MEM,MDR_OUT,A_in,B_in,out_EN,IO_OUT0,IO_OUT1,IO_EN0,IO_EN1,IR_EN;
output reg clk, reset;

ID topID(IR_OUT,reset,clk,MFC,R0_OUT,R1_OUT,R2_OUT,R3_OUT,R0_EN, R1_EN, R2_EN, R3_EN,PC_OUT,MAR_EN,RW,MEM_EN,MEM_BUS,BUS_MEM,MDR_OUT,A_in,B_in,out_EN,IO_OUT0,IO_OUT1,IO_EN0,IO_EN1,IR_EN,increment,select,busOUT);

ALU topALU(out_EN,reset,A_in,B_in,busOUT,select,busOUT);

MAR topMAR(busOUT,MAR_EN,reset,clk,MAR_OUT);

MDR topMDR(busOUT,Dataout,MEM_BUS,BUS_MEM, reset,MDR_OUT,clk,datain,busOUT);

PC topPC(reset,PC_OUT,clk,increment,busOUT);

IR topIR(busOUT,IR_EN,reset,clk,IR_OUT);

R0 topR0(busOUT,R0_EN,reset,R0_OUT,clk,busOUT);

R1 topR1(busOUT,R1_EN,reset,R1_OUT,clk,busOUT);

R2 topR2(busOUT,R2_EN,reset,R2_OUT,clk,busOUT);

R3 topR3(busOUT,R3_EN,reset,R3_OUT,clk,busOUT);

IO_0 topIO_0(busOUT,IO_EN0,reset,IO_OUT0,clk,busOUT);

IO_1 topIO_1(busOUT,IO_EN1,reset,IO_OUT1,busOUT,exit);

mainmemory topMEM(Dataout, MFC, MEM_EN, MAR_OUT,datain, RW,reset);

initial begin 
        reset = 1; clk = 0;
	#100;
	reset = 0;
     end 

always 
   #20 clk = ~clk;

endmodule
