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

module CLA_Adder(a,b,cin,sum,cout);
    input[3:0] a,b;
    input cin;
    output [3:0] sum;
    output cout;
    wire p0,p1,p2,p3,g0,g1,g2,g3,c1,c2,c3,c4;

    halfadder HA0(p0, g0, a[0], b[0]);
	halfadder HA1(p1, g1, a[1], b[1]);
	halfadder HA2(p2, g2, a[2], b[2]);
	halfadder HA3(p3, g3, a[3], b[3]);
	
    carrygenerator CG(cin, p0, p1, p2, p3, g0, g1, g2, g3, c0, c1, c2, c3, c4);
    
    assign sum[0]=p0^c0;
    assign sum[1]=p1^c1;
    assign sum[2]=p2^c2;
    assign sum[3]=p3^c3;
    assign cout=c4;
endmodule

module product(a,b,res);
  input [3:0] b;
  input [2:0] a;
  output [6:0] res;
  
  wire [4:0] r1;
  wire [3:0] r2,r3;
  wire [4:0] i1;
   
  assign r1[0]=b[0]&a[0];
  assign r1[1]=b[1]&a[0];
  assign r1[2]=b[2]&a[0];
  assign r1[3]=b[3]&a[0];
  
  assign r2[0]=b[0]&a[1];
  assign r2[1]=b[1]&a[1];
  assign r2[2]=b[2]&a[1];
  assign r2[3]=b[3]&a[1];
  
  assign r3[0]=b[0]&a[2];
  assign r3[1]=b[1]&a[2];
  assign r3[2]=b[2]&a[2];
  assign r3[3]=b[3]&a[2];
  
  assign r1[4]=1'b0;
  
  assign res[0]=r1[0];
  CLA_Adder a1(r1[4:1], r2, 1'b0, i1[3:0], i1[4]);
  assign res[1]=i1[0];
  CLA_Adder a2(i1[4:1], r3, 1'b0, res[5:2], res[6]);
endmodule
