//  timeMultiplexer.sv
//  Christian Wu
//  chrwu@g.hmc.edu
//  09/06/25

// This module takes in two four bit inputs, s1 and s2, and switches between them to drive a dual seven
// segment display, to utilize only one sevenSegmentDisplay module. The switching is done at a rate fast enough
// such that the human eye cannot detect the switching, and it appears that both displays are on at the same time.

module timeMultiplexer (
    input logic [3:0] s1, s2,
    output logic [6:0] seg,
    output logic an0, an1);

    logic signal; // select signal to choose between s1 and s2
    logic int_osc;
    logic [24:0] counter = 0;

    HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

    always_ff @(posedge int_osc) begin
        counter <= counter + 1;
        if (counter == 48000) begin
            counter <= 0;
            signal <= ~signal; 
            if (signal) begin
                an0 <= 1; // turn off an0
                an1 <= 0; // turn on an1
                sevenSegmentDisplay seg1 (.s(s2), .seg(seg)); // drive seg with s2
            end else begin
                an0 <= 0; // turn on an0
                an1 <= 1; // turn off an1
                sevenSegmentDisplay seg0 (.s(s1), .seg(seg)); // drive seg with s1
            end
    end
    end
endmodule