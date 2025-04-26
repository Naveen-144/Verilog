module decoder(x, y, z, d0, d1, d2, d3, d4, d5, d6, d7);
  input x, y, z; // Data inputs
  output d0, d1, d2, d3, d4, d5, d6, d7; // Output

   // Using AND gates for each minterm
    assign d0 = ~x & ~y & ~z; // Minterm 0
    assign d1 = ~x & ~y & z;   // Minterm 1
    assign d2 = ~x & y & ~z;  // Minterm 2
    assign d3 = ~x & y & z;    // Minterm 3
    assign d4 = x & ~y & ~z;  // Minterm 4
    assign d5 = x & ~y & z;    // Minterm 5
    assign d6 = x & y & ~z;  // Minterm 6
    assign d7 = x & y & z;    // Minterm 7

endmodule