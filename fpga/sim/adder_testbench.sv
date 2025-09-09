// Christian Wu
// chrwu@g.hmc.edu
// 09/08/25

// This module tests the 4-bit adder module by providing various test cases and checking the output.
`timescale 1ns/1ps

module adder_testbench();
    logic [3:0] a, b;
    logic [4:0] sum;
    logic [4:0] expected_sum;
    adder dut (.a(a), .b(b), .sum(sum));

    integer i,j;
    integer test_cases = 0;

    initial begin
        // Test all combinations of 4-bit inputs
        for (i = 0; i < 16; i++) begin
            for (j = 0; j < 16; j++) begin
                a = i[3:0];
                b = j[3:0];
                #1; // wait for combinational logic to settle
                test_cases++;
                expected_sum = a + b;
                assert (sum === expected_sum)
                    else $error("ASSERTION FAILED: a=%0d, b=%0d, expected sum=%0d, got sum=%0d", a, b, expected_sum, sum);
            end
        end

        $display("All %0d test cases completed with", test_cases);
        $stop;
    end
endmodule