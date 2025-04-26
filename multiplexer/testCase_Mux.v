module test;
reg i1, i2, i3, i4;
reg [1:0] sel;
wire out;

// design under test 
mux4_1 DUT(.in1(i1), .in2(i2), .in3(i3), .in4(i4), .s(sel), .y(out));

// list the input to the design
initial begin i1=1'b0; i2=1'b0; i3=1'b1; i4=1'b0; sel=2'b00; 
        #2    i1=1'b1;
        #2    sel=2'b11;
        #2    i4=1'b1;
        #2    $stop();
        end

// monitor the output whenever any of the input changes
initial begin 
  $monitor("time=%0d, i1=%b, i2=%b, i3=%b, i4=%b, sel=%b, out=%b", $time, i1, i2, i3, i4, sel, out);
end
endmodule 