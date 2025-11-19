// lp.v - low-pass filter 
module lp (
    input clk,
    input clk_enable,
    input reset,
    input signed [15:0] filter_in,
    output signed [15:0] g_raw
);
    reg signed [15:0] reg_in;
    always @(posedge clk or posedge reset) begin
        if (reset) reg_in <= 0;
        else if (clk_enable) reg_in <= filter_in;
    end
    assign g_raw = reg_in; // TODO: implement actual LPF
endmodule
