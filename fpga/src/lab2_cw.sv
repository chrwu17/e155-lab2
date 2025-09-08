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

    timeMultiplexer tm (.s1(sw[3:0]), .s2(sw[3:0]), .seg(seg), .an1(an1), .an2(an2));

    always_comb begin
        sum = s1 + s2; // calculate sum of s1 and s2
    end
endmodule