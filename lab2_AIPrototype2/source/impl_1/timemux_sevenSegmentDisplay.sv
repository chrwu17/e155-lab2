module timemux_sevenSegmentDisplay (
    input logic [3:0] input_a,    // First 4-bit input
    input logic [3:0] input_b,    // Second 4-bit input
    output logic [6:0] seg,       // Common seven segment output
    output logic enable_a,        // Enable signal for display A (active low)
    output logic enable_b         // Enable signal for display B (active low)
);

    // Internal signals
    logic int_osc;
    logic mux_select = 0;
    logic [20:0] counter = 0;
    logic [3:0] current_input;
    
    // Internal high-speed oscillator
    HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
    
    // Clock divider for multiplexing frequency
    always_ff @(posedge int_osc) begin
        counter <= counter + 1;
        if (counter == 24_000) begin  // 1kHz multiplex frequency
            mux_select <= ~mux_select;
            counter <= 0;
        end
    end
    
    // Input multiplexer
    always_comb begin
        if (mux_select)
            current_input = input_b;
        else
            current_input = input_a;
    end
    
    // Generate enable signals (active low for common anode displays)
    assign enable_a = mux_select;   // Active when mux_select is 0
    assign enable_b = ~mux_select;  // Active when mux_select is 1
    
    // Instantiate the seven segment decoder
    lab1_sevenSegmentDisplay decoder (
        .s(current_input),
        .seg(seg)
    );

endmodule