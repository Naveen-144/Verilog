module halfadder (S, C, x, y);
input x, y;
output S, C;
//Instantiate primitive gates
xor (S, x, y);
and (C, x, y);
endmodule
module carrygenerator(cin, p0, p1, p2, p3, g0, g1, g2, g3, c0, c1, c2, c3, c4);
input cin, p0, p1, p2, p3, g0, g1, g2, g3;
output c0, c1, c2, c3, c4;
assign c0=cin;
assign c1=g0|(p0&cin);
assign c2=g1|(p1&g0)|(p1&p0&cin);
assign c3=g2|(p2&g1)|(p2&p1&g0)|(p1&p1&p0&cin);
assign c4=g3|(p3&g2)|(p3&p2&g1)|(p3&p2&p1&g0)|(p3&p2&p1&p0&cin);
endmodule

module four_bit_adder (S, C4, A, B, C0);
input [3:0] A, B;
input C0;
output [3:0] S;
output C4;
wire C1,C2,C3; //Intermediate carries
//Instantiate the full adder cells
fulladder FA0 (S[0],C1,A[0],B[0],C0),
FA1 (S[1],C2,A[1],B[1],C1),
FA2 (S[2],C3,A[2],B[2],C2),
FA3 (S[3],C4,A[3],B[3],C3);
endmodule