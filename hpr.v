// hpr.v - high-pass reconstruction filter (skeleton)
module hpr (
    input clk,
    input clk_enable,
    input reset,
    input signed [15:0] in,
    output signed [15:0] out
);
    // placeholder implementation
    reg signed [15:0] r;
    always @(posedge clk or posedge reset) begin
        if (reset) r <= 0;
        else if (clk_enable) r <= in;
    end
    assign out = r;
endmodule
