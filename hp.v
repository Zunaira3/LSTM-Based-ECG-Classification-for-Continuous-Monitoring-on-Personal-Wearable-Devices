
module hp (
    input clk,
    input clk_enable,
    input reset,
    input signed [15:0] filter_in,
    output signed [15:0] f_raw
);
    // Simple one-tap pass-through (replace with actual HPF)
    reg signed [15:0] reg_in;
    always @(posedge clk or posedge reset) begin
        if (reset) reg_in <= 0;
        else if (clk_enable) reg_in <= filter_in;
    end
    assign f_raw = reg_in; // TODO: implement actual HPF
endmodule
