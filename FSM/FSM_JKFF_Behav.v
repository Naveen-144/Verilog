module JK_2S_FSM (
  input wire clk,
  input wire rst,
  input wire j,
  input wire k,
  output reg y
);


// Define state parameters
localparam S0 = 0, S1= 1;

// Define state register and next state logic
reg current_state, next_state;


// Next state logic and state register
always @(posedge clk or posedge rst) begin
  if (rst) begin
    current_state <= S0;
    end 
   else begin 
   current_state <= next_state;
   y <= current_state;
   end 
end

// State transition and output logic
always @(posedge clk or j or k) begin
  case (current_state)
    S0: begin
      if (j) next_state <= S1; else  next_state <= S0;
    end
    S1: begin
      if (k) next_state <= S0; else next_state <= S1;
    end
  endcase
   $display("INISDE_NS j = %b, k=%b CS = %b NS=%b", j, k, current_state, next_state);
end

endmodule


module jkff_fsm_test;
reg j, k, iCLK, rst;
wire Q;
integer i;

JK_2S_FSM JK0(iCLK, rst, j, k, Q); // instantiation by port name.

//4. apply test vectors
initial begin
     iCLK=0;
     for(i=0;i<20; i++) begin
             #5; iCLK = ~iCLK;
             $display("iCLK = %b, j = %b, k=%b Q = %b", iCLK, j, k, Q);
     end
end
initial begin
$dumpfile("jkff_fsm.vcd");
$dumpvars;
 j = 0; k=0; rst=1; 
 #10 rst=0;
 #8 j = 1; k =0;
 #10 j = 0; k =1;
 #10 j = 1; k =1;
 #30 j = 0; k =1;
 #10 $finish;
end
endmodule
