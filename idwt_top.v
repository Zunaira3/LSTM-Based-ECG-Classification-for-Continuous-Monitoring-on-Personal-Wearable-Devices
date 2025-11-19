// idwt_top.v - top-level inverse DWT skeleton
module idwt_top (
    input clk,
    input clk_enable,
    input reset,
    input signed [15:0] D1, D2, D3, D4,
    output signed [15:0] reconstructed_out
);
    // Upsample & reconstruct stage wiring
    wire signed [15:0] f_r, g_r, f_g_r, g_g_r, f_g_g_r, g_g_g_r;
    // Stage1 inverse
    upsample up1(.clk(clk), .clk_enable(clk_enable), .reset(reset), .g_in(D4), .f_in(D3), .g_out(), .f_out(), .clk_out());
    hpr hpr1(.clk(clk), .clk_enable(clk_enable), .reset(reset), .in(D3), .out(f_r));
    lpr lpr1(.clk(clk), .clk_enable(clk_enable), .reset(reset), .in(D4), .out(g_r));
    // Note: this is a placeholder handshake; implement accurate timing/upsampling.
    assign reconstructed_out = f_r + g_r; // final partial result: replace with real sum-of-stages
endmodule
