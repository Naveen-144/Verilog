module testbench ( );

  // Inputs and Outputs
  reg [2:0] val;
  wire out;

  // DUT instantiation
  parity_generator dut (
    .x(val[2]),
    .y(val[1]),
    .z(val[0]),
    .parity(out)    
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
      val <= i;
      #20;
      i = i + 1;
      if (i == 8) $finish;
    end
    $monitor("%d: val = %b, out = %b", $time, val, out);
  end 
endmodule