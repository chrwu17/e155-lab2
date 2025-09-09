// lab2_cw.sv
// Christian Wu
// chrwu@g.hmc.edu
// 09/06/25

// This module is the top level module for lab 2. It instantiates the timeMultiplexer module to drive the
// seven-segment display, and connects the dip switches to the inputs of the timeMultiplexer module. It also displays
// the sum of the two 4-bit inputs on five LEDs.

module lab2_cw (
    input logic [3:0] s1, s2, // dip switches
    output logic [6:0] seg, // seven-segment display
    output logic an1, an2, // anodes for the two displays
    output logic [4:0] sum); // 5 LEDs to display sum

    
    logic [3:0] sevenSegmentSignal;
    logic signal; // select signal to choose between s1 and s2
    logic clk;
	
    HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
    timeMultiplexer tm (.clk(clk), .an1(an1), .an2(an2), .signal(signal));
    sevenSegMux ssm (.s1(s1[3:0]), .s2(s2[3:0]), .enable(signal), .out(sevenSegmentSignal));
    sevenSegmentDisplay ssd (.s(sevenSegmentSignal), .seg(seg));
    adder a (.a(s1[3:0]), .b(s2[3:0]), .sum(sum[4:0]));
endmodule