module tb_four_bit_adder;

    reg  [3:0] A, B;
    wire [3:0] SUM;
    wire       COUT;

    four_bit_adder uut (
        .A(A),
        .B(B),
        .SUM(SUM),
        .COUT(COUT)
    );

    initial begin
        $monitor("Time=%0d A=%b B=%b SUM=%b COUT=%b", $time, A, B, SUM, COUT);

        A = 4'b0001; B = 4'b0010; #10;
        A = 4'b0110; B = 4'b0101; #10;
        A = 4'b1111; B = 4'b0001; #10;
        A = 4'b1010; B = 4'b0100; #10;

        $finish;
    end

endmodule
