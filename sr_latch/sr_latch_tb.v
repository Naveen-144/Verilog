module sr_latch_tb;
reg s,r; // we can modify registers to simulate the inputs
wire q, qb; // we can't modify: assigned to our module
sr_latch latch(s, r, q, qb);
initial begin

// for waveform analysis
$dumpfile("sr_latch.vcd");
//$dumpvars(s, r, q, qb);
$dumpvars;

s=0; r=0; #1 // case 1 (latch w/o state)
$display("s=%b, r=%b ==> q=%b, qb=%b # undefined", s, r, q, qb);
s=0; r=1; #1 // case 2 (reset)
$display("s=%b, r=%b ==> q=%b, qb=%b # reset, so q=0", s, r, q, qb);
s=1; r=0; #1 // case 3 (set)
$display("s=%b, r=%b ==> q=%b, qb=%b # set, so q=1", s, r, q, qb);
s=0; r=0; #1 // case 4 (latch with state)
$display("s=%b, r=%b ==> q=%b, qb=%b # latch,

so q=q (keep state)", s, r, q, qb);

s=1; r=1; #1 // case 5 (invalid state)
$display("s=%b, r=%b ==> q=%b, qb=%b # invalid state ", s, r, q, qb);
end
endmodule