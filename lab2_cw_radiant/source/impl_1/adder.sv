// Christian Wu
// chrwu@g.hmc.edu
// 09/08/25

// This module is a 4-bit adder that takes in two 4-bit inputs a and b, and outputs a 5-bit sum.
module adder (
    input logic [3:0] a, b,
    output logic [4:0] sum);

    always_comb begin
        sum = a + b;
    end
endmodule