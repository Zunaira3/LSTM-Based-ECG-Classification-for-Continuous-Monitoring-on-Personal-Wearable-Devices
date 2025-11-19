// MatrixMultiply.v
module MatrixMultiply #(parameter A=35, B=5, dataWidth=8, weightFile1="w_1.mif", weightFile2="w_2.mif")
(
    input clk,
    input rst,
    output reg [dataWidth*2-1:0] wout0,
    output reg [dataWidth*2-1:0] wout1,
    output reg [dataWidth*2-1:0] wout2,
    output reg [dataWidth*2-1:0] wout3,
    output reg [dataWidth*2-1:0] wout4,
    output reg [dataWidth*2-1:0] wout5
);
    integer ii, jj, m, n;
    integer i, j;
    integer b;
    initial b = B + 1;

    reg [dataWidth-1:0] mem1 [0:A];
    reg [dataWidth-1:0] mem2 [0:B];
    reg signed [dataWidth*2-1:0] mem3 [0:A];
    reg signed [dataWidth*2-1:0] mem4 [0:B];
    reg signed [dataWidth*2-1:0] sum;

    initial begin
        $readmemb(weightFile1, mem1);
        $readmemb(weightFile2, mem2);
    end

    // Simple counters (note: using registers safely)
    reg [31:0] icnt;
    reg [31:0] jcnt;
    always @(posedge clk or posedge rst) begin
        if (rst) begin icnt <= 0; jcnt <= 0; end
        else begin
            icnt <= (icnt >= A) ? 0 : icnt + 1;
            jcnt <= (jcnt >= B) ? 0 : jcnt + 1;
        end
    end

    always @(posedge clk) begin
        mem3[icnt] <= $signed(mem1[icnt]) * $signed(mem2[jcnt]);
    end

    always @(*) begin
        for (ii=0; ii<b; ii=ii+1) begin
            m = ii*b + B;
            n = ii*b;
            sum = 0;
            for (jj=n; jj<=m; jj=jj+1) begin
                sum = sum + mem3[jj];
            end
            mem4[ii] = sum;
        end
    end

    always @(posedge clk) begin
        wout0 <= mem4[0];
        wout1 <= mem4[1];
        wout2 <= mem4[2];
        wout3 <= mem4[3];
        wout4 <= mem4[4];
        wout5 <= mem4[5];
    end
endmodule
