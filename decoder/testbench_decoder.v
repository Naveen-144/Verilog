module testbench ( );

  // Inputs and Outputs
  reg [2:0] in;
  wire [7:0] out;

  // DUT instantiation
  decoder dut (
    .x(in[2]),
	.y(in[1]),
	.z(in[0]),
	.d0(out[7]),
	.d1(out[6]),
	.d2(out[5]),
	.d3(out[4]),
	.d4(out[3]),
	.d5(out[2]),
	.d6(out[1]),
	.d7(out[0])
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
      in <= i;
      #20;
      i = i + 1;
      if (i == 8) $finish;
    end
    $monitor("%d: Input = %b, Output = %b", $time, in, out);
  end 

endmodule