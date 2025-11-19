// upsample.v - skeleton for inverse wavelet upsampling
module upsample (
    input clk,
    input clk_enable,
    input reset,
    input signed [15:0] g_in,
    input signed [15:0] f_in,
    output reg signed [15:0] g_out,
    output reg signed [15:0] f_out,
    output reg clk_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            g_out <= 0;
            f_out <= 0;
            clk_out <= 0;
        end else if (clk_enable) begin
            g_out <= g_in; // TODO: insert zero-insertion for upsampling
            f_out <= f_in;
            clk_out <= 1;
        end
    end
endmodule
