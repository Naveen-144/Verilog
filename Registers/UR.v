module universal_register (
  input wire [3:0] data_input,
  input wire [1:0] Sel, // Control signals: ctrl[1] = left shift, ctrl[0] = right shift
  input wire clock,
  input wire left_in, input wire right_in,
  output reg [3:0] data_output
);

  reg [3:0] reg_data;
  always @(posedge clock) begin
      case(Sel)
        2'b00: reg_data <= data_input; // Parallel load
        2'b01: reg_data <= {reg_data[2:0], left_in}; // Left shift
        2'b10: reg_data <= {right_in, reg_data[3:1]}; // Right shift
        2'b11: reg_data <= reg_data; // Retain
      endcase
    end
	  
    always @(posedge clock) begin
      data_output <= reg_data;
    end
endmodule


