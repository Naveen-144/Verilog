module tff_fsm (input clk, input t, input rst, output reg y);

localparam S0 = 0, S1= 1;

// Define state register and next state logic
reg current_state, next_state;


// Next state logic and state register
always @(posedge clk or posedge rst) begin
  if (rst) begin current_state <= S0; end
   else begin
   current_state = next_state;
   y = current_state;
   end
end

// State transition and output logic
always @(posedge clk or t) begin
  case (current_state)
    S0: begin
      if (t) next_state <= S1; else  next_state <= S0;
    end
    S1: begin
      if (t) next_state <= S0; else next_state <= S1;
    end
  endcase
end

endmodule  

module tff_fsm_test;
reg t, iCLK, rst;
wire Q;
integer i;

tff_fsm T0(iCLK, t, rst, Q); // instantiation by port name.

//4. apply test vectors
initial begin
     iCLK=0;
     for(i=0;i<20; i++) begin
             #10; iCLK = ~iCLK;
             $display("iCLK = %b, t = %b, Q = %b", iCLK, t, Q);
     end
end
initial begin
$dumpfile("tff_fsm.vcd");
$dumpvars;
 t = 0;rst=1; 
 #10 rst=0;
 #25 t = 1;
 #30 t = 0;
 #25 t = 1;
 #40 $finish;
end
endmodule
