module max3b_pipe  (clk, d1, d2, d3, wy);
input   [3:0] d1, d2, d3;
input clk;
output  [3:0] wy;

reg [3:0]  wy,  r1, r2, r3, r3del, max12;


always @(posedge clk)
 begin
	r1 <= d1;
	r2 <= d2;
	r3 <= d3;
 end


always @(posedge clk)
begin
	r3del <= r3;
end
 
always @(posedge clk)
 	if ( r1 > r2) 
		max12 <= r1;
	else
		max12 <= r2;


always @(posedge clk)
 	if ( max12 > r3del) 
		wy <= max12;
	else
		wy <= r3;




endmodule

