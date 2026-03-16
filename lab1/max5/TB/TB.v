module TB();
wire clk;
wire [3:0] data1, data2, data3, data4, data5, wy, wy_pot;

max5     dut  (.clk(clk), .d1(data1), .d2(data2), .d3(data3), .d4(data4) , .d5(data5), .wy(wy) );
max5p    dutp (.clk(clk), .d1(data1), .d2(data2), .d3(data3), .d4(data4) , .d5(data5), .wy(wy_pot) );

generator stim( .clk(clk), .d1(data1), .d2(data2), .d3(data3), .d4(data4) , .d5(data5)  );

// VCD dump setup
initial begin
    $dumpfile("build/max5_wave.vcd");
    $dumpvars(0, TB);
    #20000 $finish;
end
endmodule
