// blinky.v
//
// The "Hello World" of Digital Logic!
// This example blinks the on-board user LED once a second.
//
// This Source Code is Public Domain.

module fpga_top(input wire clk, output reg WF_LED);
    reg [24:0] counter;

    // Blink LED every 1000 ms
    always @ (posedge clk) begin
        // Try using a different value here...
        // 12000000 will cause it to blink twice as fast!
        if (counter == 8000000) begin
            WF_LED   <= ~WF_LED;
            counter  <= 'b0;
        end else begin
            counter  <= counter + 'b1;
        end
    end

    // Setup CLK using internal oscillator
    //
    // We will add more documentation on this later. But basically, this
    // is a Lattice specific macro to use internal oscillator as the clock.
    // The WebFPGA board also has an external oscillator for precision
    // timing applications.
    //wire clk_en;
    //assign clk_en = 1'b1;
    //SB_HFOSC OSC_i(
        //.CLKHFEN(clk_en),
        //.CLKHFPU(clk_en),
        //.CLKHF(clk));
endmodule
