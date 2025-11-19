

module downsample (
    input clk,
    input clk_enable,
    input reset,
    input signed [15:0] in1,
    input signed [15:0] in2,
    output reg signed [15:0] out_g,
    output reg signed [15:0] out_f,
    output reg clk_out
);
    // Simple pass-through + toggle clock - replace with real downsampler
    reg toggle;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            toggle <= 0;
            out_g <= 0;
            out_f <= 0;
            clk_out <= 0;
        end else if (clk_enable) begin
            toggle <= ~toggle;
            if (toggle) begin
                out_g <= in1;
                out_f <= in2;
                clk_out <= 1;
            end else begin
                clk_out <= 0;
            end
        end
    end
endmodule
