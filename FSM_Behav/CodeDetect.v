//Detect 010_110 from inout bit sequence
module det_010_110 ( input clk,
	input rstn,
	input in,
	output out );

parameter S0 	= 0,
	S1	= 1,
	S2 	= 2,
	S3 	= 3;

reg [2:0] cur_state, next_state;

assign out = (cur_state == S3) & (~in); 

always @ (posedge clk) begin
	if (rstn) cur_state <= S0;
	else cur_state <= next_state;
	//$display("INSIDE CLK = %b, rstn = %b, in=%b out = %b CUR_STATE=%d", clk, rstn, in, out, cur_state);
end

always @ (posedge clk) begin
	case (cur_state)
	S0 :  begin next_state = S1; end

	S1: begin
	if (in) next_state = S3; else next_state = S2;
	end

	S2 : begin   next_state = S0;  	end
	S3 : begin   next_state = S0;  	end
    endcase
  end
 endmodule


  module tb;
  reg 			clk, in, rstn;
  wire 			out;
  reg [1:0] l_dly;
  reg 			tb_in;
  integer 	loop = 1;
  integer    i=0;

  always #10 clk = ~clk;

  det_010_110 m10 ( .clk(clk), .rstn(rstn), .in(in), .out(out) );

  always @(posedge clk) begin
	  $display("CLK = %b, rstn = %b, in=%b out = %b", clk, rstn, in, out);
	end

  initial begin
	  clk <= 0;
	  rstn <= 1;
	  in <= 0;
	  repeat (2) @ (posedge clk);
	  rstn <= 0;

	  // Generate a directed pattern
	  @(posedge clk) in <= 0;
	  @(posedge clk) in <= 1;
	  @(posedge clk) in <= 0; 		// Pattern is completed
	  @(posedge clk) in <= 1;
	  @(posedge clk) in <= 0;
	  @(posedge clk) in <= 1;
	  @(posedge clk) in <= 1;
	  @(posedge clk) in <= 1;
	  @(posedge clk) in <= 0; 	 // Pattern completed again
	  @(posedge clk) in <= 1;
	  @(posedge clk) in <= 1;
	  @(posedge clk) in <= 1;

	  // Wait for sometime before quitting simulation
	  #100 $finish;
  end
  endmodule
