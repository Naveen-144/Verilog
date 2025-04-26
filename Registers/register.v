module Register(clock, r_enable, data_in, data_out);

input             clock;
input             r_enable;
input      [3:0] data_in;
output reg [3:0] data_out;

reg [3:0] data_stored;

always @(posedge clock)
	begin
	    if(r_enable)
        	data_stored = data_in;
	end

always @(posedge clock) begin
    data_out <= data_stored;
  end

//assign data_out = reg_data;

endmodule



module RegisterTestbench;

reg         clock = 0;
reg         enable = 1;
reg  [3:0] value_in;
wire [3:0] value_out;

always #5 clock = !clock;

initial $dumpfile("registertestbench.vcd");
initial $dumpvars(0, RegisterTestbench);

Register r(clock, enable, value_in, value_out);

initial begin
    //These events must be in chronological order.
    # 5 value_in = 3;
    # 5 value_in = 12;
    # 5 value_in = 5;
    # 5 value_in = 14;
    # 5 value_in = 1;
    # 5 $finish;
end
endmodule
