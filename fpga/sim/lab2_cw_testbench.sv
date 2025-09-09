// lab2_cw_testbench.sv
// Christian Wu
// chrwu@g.hmc.edu
// 09/08/25

// Simple testbench for lab2_cw module - tests each case one at a time

`timescale 1ns / 1ps

module lab2_cw_testbench;
    logic [3:0] s1, s2;
    logic [6:0] seg;
    logic [6:0] expected_seg;
    logic an1, an2;
    logic [4:0] sum;
    logic [4:0] expected_sum;
    
    logic [6:0] seg_patterns [16] = {
        7'b1000000, // 0
        7'b1111001, // 1
        7'b0100100, // 2
        7'b0110000, // 3
        7'b0011001, // 4
        7'b0010010, // 5
        7'b0000010, // 6
        7'b1111000, // 7
        7'b0000000, // 8
        7'b0010000, // 9
        7'b0001000, // A
        7'b0000011, // b
        7'b1000110, // C
        7'b0100001, // d
        7'b0000110, // E
        7'b0001110  // F
    };
    
    // Instantiate the Device Under Test (DUT)
    lab2_cw dut (.s1(s1), .s2(s2), .seg(seg), .an1(an1), .an2(an2), .sum(sum));
    
    initial begin
        // Test Case 1: 0 + 0 = 0
        s1 = 4'h0;
        s2 = 4'h0;
        expected_sum = 5'd0;
        #2000000; // Wait 2ms for display to switch (500Hz = 2ms period)
        
        assert (sum === expected_sum)
        else
            $error("Sum wrong: %0d + %0d = %0d, expected %0d", s1, s2, sum, expected_sum);
        
        // Wait for display 1 to be active (an1 = 0)
        wait (an1 == 0); #10;
        expected_seg = seg_patterns[s1];
        assert (seg === expected_seg)
        else
            $error("Display 1 wrong pattern for s1=%h, expected=%b, got=%b", s1, seg_patterns[s1], seg);
        
        // Wait for display 2 to be active (an2 = 0) 
        wait (an2 == 0); #10;
        expected_seg = seg_patterns[s2];
        assert (seg === expected_seg)
        else
            $error("Display 2 wrong pattern for s2=%h, expected=%b, got=%b", s2, seg_patterns[s2], seg);
        
        // Test Case 2: 5 + 3 = 8
        s1 = 4'h5;
        s2 = 4'h3;
        expected_sum = 5'd8;
        #100;
        
        assert (sum === expected_sum)
        else
            $error("Sum wrong: %0d + %0d = %0d, expected %0d", s1, s2, sum, expected_sum);
        
        wait (an1 == 0); #10;
        expected_seg = seg_patterns[s1];
        assert (seg === expected_seg)
        else
            $error("Display 1 wrong pattern for s1=%h, expected=%b, got=%b", s1, seg_patterns[s1], seg);
        
        wait (an2 == 0); #10;
        expected_seg = seg_patterns[s2];
        assert (seg === expected_seg)
        else
            $error("Display 2 wrong pattern for s2=%h, expected=%b, got=%b", s2, seg_patterns[s2], seg);
        
        // Test Case 3: A + 7 = 17
        s1 = 4'hA;
        s2 = 4'h7;
        expected_sum = 5'd17;
        #100;
        
        assert (sum === expected_sum)
        else
            $error("Sum wrong: %0d + %0d = %0d, expected %0d", s1, s2, sum, expected_sum);
        
        wait (an1 == 0); #10;
        expected_seg = seg_patterns[s1];
        assert (seg === expected_seg)
        else
            $error("Display 1 wrong pattern for s1=%h, expected=%b, got=%b", s1, seg_patterns[s1], seg);
        
        wait (an2 == 0); #10;
        expected_seg = seg_patterns[s2];
        assert (seg === expected_seg)
        else
            $error("Display 2 wrong pattern for s2=%h, expected=%b, got=%b", s2, seg_patterns[s2], seg);
        
        // Test Case 4: F + F = 30 (maximum)
        s1 = 4'hF;
        s2 = 4'hF;
        expected_sum = 5'd30;
        #100;
        
        assert (sum === expected_sum)
        else
            $error("Sum wrong: %0d + %0d = %0d, expected %0d", s1, s2, sum, expected_sum);
        
        wait (an1 == 0); #10;
        expected_seg = seg_patterns[s1];
        assert (seg === expected_seg)
        else
            $error("Display 1 wrong pattern for s1=%h, expected=%b, got=%b", s1, seg_patterns[s1], seg);
        
        wait (an2 == 0); #10;
        expected_seg = seg_patterns[s2];
        assert (seg === expected_seg)
        else
            $error("Display 2 wrong pattern for s2=%h, expected=%b, got=%b", s2, seg_patterns[s2], seg);
        
        // Test Case 5: 8 + 8 = 16
        s1 = 4'h8;
        s2 = 4'h8;
        expected_sum = 5'd16;
        #100;
        
        assert (sum === expected_sum)
        else
            $error("Sum wrong: %0d + %0d = %0d, expected %0d", s1, s2, sum, expected_sum);
        
        wait (an1 == 0); #10;
        expected_seg = seg_patterns[s1];
        assert (seg === expected_seg)
        else
            $error("Display 1 wrong pattern for s1=%h, expected=%b, got=%b", s1, seg_patterns[s1], seg);
        
        wait (an2 == 0); #10;
        expected_seg = seg_patterns[s2];
        assert (seg === expected_seg)
        else
            $error("Display 2 wrong pattern for s2=%h, expected=%b, got=%b", s2, seg_patterns[s2], seg);
        
        $display("All tests successfully completed.");
        $stop;
    end
    
endmodule