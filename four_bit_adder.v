module four_bit_adder (
    input  [3:0] A,     // First 4-bit input
    input  [3:0] B,     // Second 4-bit input
    output [3:0] SUM,   // 4-bit sum output
    output       COUT   // Carry out
);

    assign {COUT, SUM} = A + B;

endmodule
