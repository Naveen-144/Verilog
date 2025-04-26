module BCD_to_Excess3 (
  input A, B, C, D,
  output z, w, x, y
);
 assign z = ~D; 
 assign y = (C & D) | (~C & ~D);
 assign x = ~B & C | ~B & D | (B & ~C & ~D);
 assign w = A | (B & C) | (B & D); 
endmodule
