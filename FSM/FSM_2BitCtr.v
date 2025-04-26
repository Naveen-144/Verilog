module DFF(D,clk,rst, Q);
	input wire D; // Data input 
	input wire clk; // clock input 
	input rst;
	output reg Q; // output Q 
	
	always @ (posedge rst) begin
        if (rst) Q=0;
	end

	always @(posedge clk) begin
		if (!rst) Q <= D; 
	end 
endmodule

module ctr2bit_fsm (input clk, input rst, output q1, output q0);
	wire NS0, NS1, NS2, S0, S1, S2;

	DFF D0(NS0, clk, rst, S0);
	DFF D1(NS1, clk, rst, S1);
	
	assign NS1 = S1 ^ S0;//NS logic
	assign NS0 = ~S0;//NS logic
	
	assign q1 = S1;  //output logic
	assign q0 = S0;  //output logic
endmodule  

module ctr2bit_fsm_test;
reg iCLK, rst;
wire Q1, Q0;
integer i;

ctr2bit_fsm CTR2(iCLK, rst, Q1, Q0); // instantiation by port name.

//4. apply test vectors
initial begin
     iCLK=0;
     for(i=0;i<20; i++) begin
             #10; iCLK = ~iCLK;
             $display("iCLK = %b, Q0 = %b Q1=%b", iCLK, Q1, Q0);
     end
end
initial begin
$dumpfile("ctr2bit_fsm.vcd");
$dumpvars;
 rst=1; 
 #10 rst=0;
 #125 rst = 1;
 #40 $finish;
end
endmodule
