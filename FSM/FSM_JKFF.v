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

module jkff_fsm (input clk, input j, input k, input rst, output q);
	wire NS, S;
	DFF D0(NS, clk, rst, S);
	assign NS = (j&~q)|(~k&q) ;//NS logic
	assign q = S;  //output logic
endmodule  

module jkff_fsm_test;
reg j, k, iCLK, rst;
wire Q;
integer i;

jkff_fsm JK0(iCLK, j, k, rst, Q); // instantiation by port name.

//4. apply test vectors
initial begin
     iCLK=0;
     for(i=0;i<20; i++) begin
             #10; iCLK = ~iCLK;
             $display("iCLK = %b, j = %b, k=%b Q = %b", iCLK, j, k, Q);
     end
end
initial begin
$dumpfile("jkff_fsm.vcd");
$dumpvars;
 j = 0; k=0; rst=1; 
 #10 rst=0;
 #21 j = 1; k =1;
 #32 j = 0; k =1;
 #23 j = 1; k =0;
 #42 $finish;
end
endmodule
