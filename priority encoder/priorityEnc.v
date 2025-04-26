module priority_encoder(p0, p1, p2, p3, p4, p5, p6, p7, z1, z2, z4);
  input p0, p1, p2, p3, p4, p5, p6, p7; // Data inputs
  output z1, z2, z4; // Output

  assign z1 = (p1 & ~p2 & ~p4 & ~p6) | (p3 & ~p4 & ~p6) | (p5 & ~p6) | p7;
  assign z2 = (p2 & ~p4 & ~p5) | (p3 & ~p4 & ~p5) | p6 | p7;
  assign z4 =  p4 | p5 | p6 | p7;
endmodule