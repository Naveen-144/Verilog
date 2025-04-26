module jk_ff(input j, input k, 
  	    input clk, output q);   
reg q;  
 always @ (posedge clk)  
   case ({j,k})  
      2'b00 :  q <= q;  
      2'b01 :  q <= 0;  
      2'b10 :  q <= 1;  
      2'b11 :  q <= ~q;  
   endcase  
endmodule  

module jk_ff_test;
reg J, K, iCLK;
wire Q, Qb;
integer i;

jk_ff jkff(J, K, iCLK, Q); // instantiation by port name.


initial begin
     iCLK=0;
     for(i=0;i<10; i++) begin 
	     #10; iCLK = ~iCLK;
	     $display("iCLK = %b, J = %b, K = %b, Q = %b", iCLK, J, K, Q);
     end
end
initial begin
$dumpfile("jk_ff.vcd");
$dumpvars;
     	J <= 0;  K <= 0;    
  #5 	J <= 0;  K <= 1;  
  #20 	J <= 1;  K <= 0;  
  #20   J <= 1;  K <= 1;  
  #20   $finish;  
end
endmodule
