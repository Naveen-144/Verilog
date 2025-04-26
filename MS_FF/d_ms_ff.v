module d_latch (en,d,q);
input en, d;
output reg q;
always@(*) begin
  if(en) begin
     q=d;
   end
end
endmodule

module d_ff_struct (clk,d,q,qb);
input clk,d;
output q,qb;
wire w1;
d_latch MASTER (~clk,d,w1);
d_latch SLAVE (clk,w1,q);
  assign qb=~q;
endmodule

module dff_test;
reg D, iCLK;
wire Q, Qb;
integer i;
//2. Instantiate the module we want to test. We have instantiated the dff_behavior

d_ff_struct df(iCLK, D, Q, Qb); // instantiation by port name.


//4. apply test vectors
initial begin
     iCLK=0;
     for(i=0;i<10; i++) begin 
	     #10; iCLK = ~iCLK;
	     $display("iCLK = %b, D = %b, Q = %b, Qb = %b", iCLK, D, Q, Qb);
     end
end
initial begin
$dumpfile("d_ms_ff_vcd.vcd");
//3. Monitor TB ports
//$display("iCLK = %b, D = %b, Q = %b, QBAR = %b", iCLK, D, Q, Qb);
$dumpvars;
 D = 0;
 #25; D = 1;
 #30; D = 0;
 #25; D = 1;
end
endmodule


