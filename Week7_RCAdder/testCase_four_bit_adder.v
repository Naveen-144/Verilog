module testbench ( );
// Inputs
reg [3:0] a;
reg [3:0] b;
reg cin;
// Outputs
wire [3:0] sum;
wire cout;
four_bit_adder DUT(
.A(a),
.B(b),
.C0(cin),
.S(sum),
.C4(cout)
);
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
cin <= $random%2;
#20;
i = i + 1;
if (i == 10) $finish;
end
$monitor("%d: a = %b, b = %b, cin = %b, sum = %b, cout = %b", $time, a, b, cin, sum, cout);
end
endmodule