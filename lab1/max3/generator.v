
`timescale 1ps/1ps

module generator ( clk, d1, d2, d3, d4, d5);
output clk;
output [3:0] d1, d2, d3, d4, d5;

reg clk;
reg [3:0] d1, d2, d3, d4, d5;


initial
begin
    clk <= 0;
    d1  <= 0;
    d2  <= 0;
    d3  <= 0;
    d4  <= 10;
    d5  <= 15;
end


initial
begin
	d1 <= #180   4'b0000;
	d2 <= #2450  4'b0111;
	d3 <= #5000  4'b1000;
	d1 <= #9000  4'b1110;
  end



always 
begin
 #1000 clk <= 0;
 #1000 clk <= 1;
end

initial #20000 $finish();

endmodule

