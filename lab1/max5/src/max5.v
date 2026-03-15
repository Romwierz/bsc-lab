module max5 (clk, d1, d2, d3, d4, d5, wy);
input  clk;
input  [3:0] d1, d2, d3, d4, d5;
output [3:0] wy;

reg [3:0] wy, r1, r2, r3, r4, r5, max12, max34, max1234, max;

always @(posedge clk)
begin
    r1 <= d1;
    r2 <= d2;
    r3 <= d3;
    r4 <= d4;
    r5 <= d5;
end

///////////////
always @(r1, r2)
    if (r1 > r2) 
        max12 <= r1;
    else
        max12 <= r2;

always @(r3, r4)
    if (r3 > r4) 
        max34 <= r3;
    else
        max34 <= r4;
		
///////////////
always @(max12, max34)
    if (max12 > max34) 
        max1234 <= max12;
    else
        max1234 <= max34;

///////////////
always @(max1234, r5)
    if (max1234 > r5) 
        max <= max1234;
    else
        max <= r5;

always @(posedge clk) wy = max;

endmodule

