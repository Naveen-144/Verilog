//Gate-level hierarchical description of 4-bit adder 
// Description of half adder
module halfadder (S, C, x, y);
   input x, y;
   output S, C;
   //Instantiate primitive gates
   xor (S, x, y);
   and (C, x, y);
endmodule

//Description of full adder
module fulladder (S, C, x, y, z);
   input x, y, z;
   output S, C;
   wire S1, D1, D2; //Outputs of first XOR and two AND gates 
   //Instantiate the halfadder 
    halfadder HA1 (S1, D1, x, y); 
    halfadder HA2 (S, D2, S1, z);
    or  g1 (C, D2, D1);
endmodule


module four_bit_adder (S, C4, A, B, C0);
   input [3:0] A, B;
   input C0;
   output [3:0] S; 
   output C4;
   wire C1,C2,C3;  //Intermediate carries

   //Instantiate the full adder cells
   fulladder  FA0 (S[0],C1,A[0],B[0],C0),
              FA1 (S[1],C2,A[1],B[1],C1),
              FA2 (S[2],C3,A[2],B[2],C2), 
              FA3 (S[3],C4,A[3],B[3],C3);
endmodule

module bcd_adder (A, B, Cin, S, Cout);
input [3:0] A, B;
input Cin;
output [3:0] S;
output Cout;

wire carry, carry1;
wire [3:0] sum, b;
wire z;

  four_bit_adder Add1 (.A(A), .B(B), .C0(Cin), .S(sum), .C4(carry));
  four_bit_adder Add2 (.A(sum), .B(b), .C0(1'b0), .S(S), .C4(carry1));
  assign z = (sum[3] & sum[2]) | (sum[3] & sum[1]) | carry;
  assign b = {1'b0,z,z,1'b0};
  assign Cout = z;
 
endmodule