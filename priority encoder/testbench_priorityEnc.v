module testbench (
  );

  // Inputs and Outputs
  reg [7:0] in;
  wire [2:0] out;

  // DUT instantiation
  priority_encoder dut (
    .p0(in[7]),
	.p1(in[6]),
	.p2(in[5]),
	.p3(in[4]),
	.p4(in[3]),
	.p5(in[2]),
	.p6(in[1]),
	.p7(in[0]),
	.z1(out[0]),
	.z2(out[1]),
	.z4(out[2])	
  );

  // Clock and reset signals
  reg clk;
  reg rst;

  // Initial values
  initial begin
    clk = 0;
    rst = 1;
    #20;
    rst = 0;
  end

  // Clock generator
  always begin
    #10 clk = ~clk;
  end

  // Test sequence
  reg [3:0] i;
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      i = 0;
    end else begin
      // Apply all possible BCD values (0-9)
      in <= $random%256;
      #20;
      i = i + 1;
      if (i == 10) $finish;
    end
    $monitor("%d: Input = %b, Output = %b", $time, in, out);
  end 

endmodule