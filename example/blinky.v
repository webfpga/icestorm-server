module top(input wire WF_CLK, output reg WF_LED);
    reg [23:0] counter;

    always @(posedge WF_CLK) begin
        if (counter == 8000000) begin
            WF_LED  <= ~WF_LED;
            counter <= 24'b0;
        end else begin
            counter <= counter + 'b1;
        end
    end
endmodule
