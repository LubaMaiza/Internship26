module top_tb;
    // --- Inputs to the Top Module (Reg) ---
    reg [3:0] data;
    reg rst, clk;
    reg [7:1] ham;

    // --- Outputs from the Top Module (Wire) ---
    wire [7:1] hamming;
    wire [2:0] error;   // 3-bit Syndrome
    wire ready;

    // --- Instantiate the TOP module ---
    top master_uut(
        .data(data),
        .rst(rst),
        .clk(clk),
        .hamming(hamming),
        .ham(ham),
        .error(error),
        .ready(ready)
    );

    // --- Clock Generation (10ns period) ---
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    integer i;

    // --- Main Test Sequence ---
    initial begin
        // 1. Initial State & Reset
        rst = 1;
        data = 4'b0000;
        ham = 7'b0000000;
        
        #15; // Hold reset long enough for a clock edge
        rst = 0;
        
        $display("--- Starting Generator Test Loop (0-15) ---");
        // 2. Loop through all inputs for the Generator
        for (i = 0; i < 16; i = i + 1) begin
            @(negedge clk);
            data = i;
            
            // Allow time for the FSM to transition and display result
            #2; 
            if (ready) begin
                $display("Time %0t: Input %h -> Hamming %h [Ready: %b]", $time, data, hamming, ready);
            end
        end

        $display("\n--- Starting Checker Audit Test (Microcontroller Simulation) ---");
        
        // Scenario A: Correct Data (Data 1 should produce 4b)
        // Expected Syndrome: 000
        @(negedge clk);
        ham = 7'h4b; 
        #2; $display("Time %0t: Testing 4b (No Error)   -> Syndrome: %b", $time, error);

        // Scenario B: Error in Bit 1 (4b is 1001011 -> flipped last bit to 0 is 4a)
        // Expected Syndrome: 001
        @(negedge clk);
        ham = 7'h4a; 
        #2; $display("Time %0t: Testing 4a (Bit 1 Err) -> Syndrome: %b", $time, error);

        // Scenario C: Error in Bit 4 (4b is 1001011 -> flipped bit 4 to 0 is 5b)
        // Expected Syndrome: 100
        @(negedge clk);
        ham = 7'h5b; 
        #2; $display("Time %0t: Testing 5b (Bit 4 Err) -> Syndrome: %b", $time, error);

        // Scenario D: Error in Bit 7 (4b is 1001011 -> flipped bit 7 to 0 is 0b)
        // Expected Syndrome: 111
        @(negedge clk);
        ham = 7'h0b; 
        #2; $display("Time %0t: Testing 0b (Bit 7 Err) -> Syndrome: %b", $time, error);

        // 4. End Simulation
        repeat(5) @(posedge clk);
        $display("\n--- All tests completed successfully ---");
        $finish;
    end      

endmodule