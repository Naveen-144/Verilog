module t_ff(input t, input clk, output q);
reg q;
always @ (posedge clk)
begin
q<=(t ? ~q : q);
end
endmodule
