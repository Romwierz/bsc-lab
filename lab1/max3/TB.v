module TB();
wire clk;
wire [3:0] data1, data2, data3, wy_pipe, wy;


max3b_reg     dut_b_reg ( .clk(clk), .d1(data1), .d2(data2), .d3(data3), .wy(wy) );
max3b_pipe     dut_b_pipe ( .clk(clk), .d1(data1), .d2(data2), .d3(data3), .wy(wy_pipe) );

generator stim( .clk(clk), .d1(data1), .d2(data2), .d3(data3));

// VCD dump setup
initial begin
    $dumpfile("build/max3_wave.vcd");
    $dumpvars(0, TB);
    #20000 $finish;
end

endmodule
