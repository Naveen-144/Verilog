//Implementation of T-FF using FSM of T-FF
//Implementation of T-FF using D-FF

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

module tff_fsm (input clk, input t, input rst, output q);
	wire NS, S;
	DFF D0(NS, clk, rst, S);
	assign NS = t ^ S;//NS logic
	assign q = S;  //output logic
endmodule  

module tff_fsm_test;
reg t, iCLK, rst;
wire Q;
integer i;

tff_fsm T0(iCLK, t, rst, Q); // instantiation by port name.

//4. apply test vectors
initial begin
     iCLK=0;
     for(i=0;i<20; i++) begin
             #10; iCLK = ~iCLK;
             $display("iCLK = %b, t = %b, Q = %b", iCLK, t, Q);
     end
end
initial begin
$dumpfile("tff_fsm.vcd");
$dumpvars;
 t = 0;rst=1; 
 #10 rst=0;
 #25 t = 1;
 #30 t = 0;
 #25 t = 1;
 #40 $finish;
end
endmodule
