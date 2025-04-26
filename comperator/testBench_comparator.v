module testbench ( );

  // Inputs and Outputs
  reg [3:0] a;
  reg [3:0] b;
  wire E;
  wire G;
  wire L;

  // DUT instantiation
  comparator dut (
    .A(a),
    .B(b), 
	.AEqualB(E),
    .AgreaterThanB(G),
    .ALessThanB(L) 
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
      // Apply all possible val values (0-9)
      a <= $random%16;
	  b <= $random%16;
      #20;
      i = i + 1;
      if (i == 10) $finish;
    end
     $monitor("%d: a = %b, b = %b, E = %b, G = %b, L = %b", $time, a, b, E, G, L);
  end 
endmodule