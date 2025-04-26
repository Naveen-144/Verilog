
module tff (output reg q, input t, input clk, input rst);  
      always @ (posedge rst) begin
        if (rst) q=0;
      end
	
      always @ (posedge clk) begin  
	      if (~rst) begin 
		      if (t)  
	                q <= ~q;  
        	       else  q <= q;  
	     end
      end  
endmodule  


module ripplecounter(clk,t, q,rst, ffrst);
  input clk,t, rst;
  output [2:0]q;
  output ffrst;
  // initiate 3 T-FF to update the count
  tff tf1(q[0],t, clk, ffrst);
  tff tf2(q[1],t, ~q[0], ffrst);
  tff tf3(q[2],t, ~q[1], ffrst);
  assign #1 ffrst=rst|(q[2]&q[1]);
endmodule

module tb;
    // input to be stored in reg and output as net(wire)
    reg clk, rst;
    reg t; 
    wire ffrst;
    wire [2:0]q;

    // instantiate the ripplecounter design block
    ripplecounter dut(clk,t,q, rst, ffrst);

    // generate clock pulse
    // initially provide 0
    // then inside always block toggle 
    // clock every 5 time units
    initial

      clk = 0;
    always
      #5 clk = ~clk;

    // provide reset values as the input
    initial
       begin
    	$dumpfile("Mod6Counter.vcd");
    	$dumpvars;
	 rst=0;
      	 t = 1;
	 #10 rst=1;
	 #10 rst=0;
	 #100 rst=1;
	 #10 rst=0;
	 #30 $finish;
       end
       initial
        $monitor("time=%g, rst=%b, clk=%b,t=%b, q=%d ffrst=%b",$time,rst, clk,t, q, ffrst);
endmodule
