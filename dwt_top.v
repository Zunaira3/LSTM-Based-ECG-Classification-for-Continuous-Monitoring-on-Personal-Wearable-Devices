
module dwt_top (
    input clk,
    input clk_enable,
    input reset,
    input signed [15:0] filter_in,
    output signed [15:0] D1, D2, D3, D4
);
    // Stage 1
    wire signed [15:0] f_raw, g_raw;
    hp hp1(.clk(clk), .clk_enable(clk_enable), .reset(reset), .filter_in(filter_in), .f_raw(f_raw));
    lp lp1(.clk(clk), .clk_enable(clk_enable), .reset(reset), .filter_in(filter_in), .g_raw(g_raw));
    // downsample to clk_2 (placeholder)
    wire signed [15:0] f, g;
    wire clk_2;
    downsample ds1(.clk(clk), .clk_enable(clk_enable), .reset(reset), .in1(g_raw), .in2(f_raw), .out_g(g), .out_f(f), .clk_out(clk_2));

    // Stage 2 (apply hp/lp on g and f as needed)
    wire signed [15:0] f_g_raw, g_g_raw, f_g, g_g;
    hp hp2(.clk(clk_2), .clk_enable(clk_enable), .reset(reset), .filter_in(g), .f_raw(f_g_raw));
    lp lp2(.clk(clk_2), .clk_enable(clk_enable), .reset(reset), .filter_in(g), .g_raw(g_g_raw));
    wire clk_4;
    downsample ds2(.clk(clk_2), .clk_enable(clk_enable), .reset(reset), .in1(g_g_raw), .in2(f_g_raw), .out_g(g_g), .out_f(f_g), .clk_out(clk_4));

    // Stage 3
    wire signed [15:0] f_g_g_raw, g_g_g_raw, f_g_g, g_g_g;
    hp hp3(.clk(clk_4), .clk_enable(clk_enable), .reset(reset), .filter_in(g_g), .f_raw(f_g_g_raw));
    lp lp3(.clk(clk_4), .clk_enable(clk_enable), .reset(reset), .filter_in(g_g), .g_raw(g_g_g_raw));
    wire clk_8;
    downsample ds3(.clk(clk_4), .clk_enable(clk_enable), .reset(reset), .in1(g_g_g_raw), .in2(f_g_g_raw), .out_g(g_g_g), .out_f(f_g_g), .clk_out(clk_8));

    // Assign outputs (placeholders)
    assign D4 = g_g_g;
    assign D3 = f_g_g;
    assign D2 = g_g;
    assign D1 = f_g;
endmodule
