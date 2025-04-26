module testbench (
  );

  // Inputs and Outputs
  reg [3:0] bcd;
  wire [3:0] excess3;

  // DUT instantiation
  BCD_to_Excess3 dut (
    .A(bcd[3]),
    .B(bcd[2]),
    .C(bcd[1]),
    .D(bcd[0]),
    .w(excess3[3]),
    .x(excess3[2]),
    .y(excess3[1]),
    .z(excess3[0])
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
      bcd <= i;
      #20;
      i = i + 1;
      if (i == 10) $finish;
    end
    $monitor("%d: BCD = %b, Excess-3 = %b", $time, bcd, excess3);
  end 

endmodule