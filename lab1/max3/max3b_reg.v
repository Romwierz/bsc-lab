module max3b_reg  (clk, d1, d2, d3, wy);
input   [3:0] d1, d2, d3;
input clk;
output  [3:0] wy;

reg [3:0]  wy,  r1, r2, r3, max12, max123;


always @(posedge clk)
 begin
	r1 <= d1;
	r2 <= d2;
	r3 <= d3;
 end

always @(r1, r2)
 	if ( r1 > r2) 
		max12 <= r1;
	else
		max12 <= r2;

always @(max12, r3)
 	if ( max12 > r3) 
		max123 <= max12;
	else
		max123 <= r3;

always @(posedge clk)
	wy <= max123;

endmodule

