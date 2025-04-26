
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


module ripplecounter(clk,t, rst, q);
  input clk,t, rst;
  output [3:0]q;
  // initiate 4 T-FF to update the count
  tff tf1(q[0],t, clk, rst);
  tff tf2(q[1],q[0], clk, rst);
  tff tf3(q[2],q[0]&q[1], clk, rst);
  tff tf4(q[3],q[0]&q[1]&q[2], clk, rst);
endmodule

module tb;
    // input to be stored in reg and output as net(wire)
    reg clk, rst;
    reg t; 
    wire [3:0]q;

    // instantiate the ripplecounter design block
    ripplecounter dut(clk,t,rst,q);

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
    	$dumpfile("SyncCounter.vcd");
    	$dumpvars;
	 rst=0;
      	 t = 1;
	 #10 rst=1;
	 #10 rst=0;
	 #185 rst=1;
	 #10 rst=0;
	 #30 $finish;
       end
       initial
        $monitor("time=%g, rst=%b, clk=%b,t=%b, q=%d",$time,rst, clk,t, q);
endmodule
