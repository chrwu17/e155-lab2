// Time-multiplexed seven segment decoder for two displays
// Common anode seven segment display driver
module seven_seg_decoder_mux (
    input  logic        clk,           // Clock input
    input  logic        rst_n,         // Active-low reset
    input  logic [3:0]  digit0_in,     // First 4-bit input
    input  logic [3:0]  digit1_in,     // Second 4-bit input
    output logic [6:0]  seg0_out,      // Seven segment output for display 0 (a-g)
    output logic [6:0]  seg1_out,      // Seven segment output for display 1 (a-g)
    output logic        digit0_enable, // Enable signal for display 0
    output logic        digit1_enable  // Enable signal for display 1
);

    // Internal signals
    logic [3:0] mux_input;     // Multiplexed input to decoder
    logic [6:0] decoded_seg;   // Output from seven segment decoder
    logic       mux_select;    // Multiplexer select signal
    logic [6:0] seg0_reg;      // Registered output for display 0
    logic [6:0] seg1_reg;      // Registered output for display 1
    
    // Clock divider for multiplexing (adjust counter width for desired refresh rate)
    // With a typical 50MHz clock, this gives ~763Hz refresh per display
    logic [15:0] clk_counter;
    
    // Clock divider and multiplexer select generation
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            clk_counter <= 16'd0;
            mux_select <= 1'b0;
        end else begin
            clk_counter <= clk_counter + 1;
            // Toggle mux_select at MSB of counter
            mux_select <= clk_counter[15];
        end
    end
    
    // Input multiplexer
    always_comb begin
        case (mux_select)
            1'b0: mux_input = digit0_in;
            1'b1: mux_input = digit1_in;
        endcase
    end
    
    // Seven segment decoder (common anode - active low outputs)
    // Segments: a=bit6, b=bit5, c=bit4, d=bit3, e=bit2, f=bit1, g=bit0
    always_comb begin
        case (mux_input)
            4'h0: decoded_seg = 7'b1000000; // 0
            4'h1: decoded_seg = 7'b1111001; // 1
            4'h2: decoded_seg = 7'b0100100; // 2
            4'h3: decoded_seg = 7'b0110000; // 3
            4'h4: decoded_seg = 7'b0011001; // 4
            4'h5: decoded_seg = 7'b0010010; // 5
            4'h6: decoded_seg = 7'b0000010; // 6
            4'h7: decoded_seg = 7'b1111000; // 7
            4'h8: decoded_seg = 7'b0000000; // 8
            4'h9: decoded_seg = 7'b0010000; // 9
            4'hA: decoded_seg = 7'b0001000; // A
            4'hB: decoded_seg = 7'b0000011; // b
            4'hC: decoded_seg = 7'b1000110; // C
            4'hD: decoded_seg = 7'b0100001; // d
            4'hE: decoded_seg = 7'b0000110; // E
            4'hF: decoded_seg = 7'b0001110; // F
        endcase
    end
    
    // Output registers - capture decoded value when corresponding digit is selected
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            seg0_reg <= 7'b1111111; // All segments off (common anode)
            seg1_reg <= 7'b1111111;
        end else begin
            if (mux_select == 1'b0) begin
                seg0_reg <= decoded_seg;
            end else begin
                seg1_reg <= decoded_seg;
            end
        end
    end
    
    // Output assignments
    assign seg0_out = seg0_reg;
    assign seg1_out = seg1_reg;
    
    // Generate enable signals (active low for common anode displays)
    // Only one display is enabled at a time for time multiplexing
    assign digit0_enable = ~mux_select;  // Active when mux_select = 0
    assign digit1_enable = mux_select;   // Active when mux_select = 1

endmodule