module mux4_1(in1, in2, in3, in4, s, y);
  input in1, in2, in3, in4; // Data inputs
  input [1:0] s; // Select lines
  output y; // Output

  assign y =  (~s[1] & ~s[0] & in1) | (~s[1] &  s[0] & in2) | (s[1]  & ~s[0] & in3) | (s[1]  &  s[0] & in4);
endmodule
