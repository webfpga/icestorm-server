module fpga_top(input wire WF_CLK, input wire WF_BUTTON, output reg WF_LED);
    reg [23:0] counter;

    always @(posedge WF_CLK) begin
        if (counter == (WF_BUTTON ? 8000000 : 500000)) begin
            WF_LED  <= ~WF_LED;
            counter <= 24'b0;
        end else begin
            counter <= counter + 'b1;
        end
    end
endmodule
