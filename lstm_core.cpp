// lstm_core.cpp 
#include "lstm_core.h"

// NOTE: this is a template: adapt sizes and types to your project and toolchain
void lstm_core(dtype inputs[], dtype w_all[][256], dtype &h_out, int m, int m2) {
#pragma HLS interface ap_memory port=w_all
#pragma HLS pipeline II=1

    dtype gates[1024];
    dtype ff[512], fi[512], fo[512], fC[512];
    dtype ff2[512], fi2[512], fo2[512], arr[512], c[512], h[512];

    // Split the big multiply loops into four parts (as in your report)
    for (int j=0; j<m; j++) {
#pragma HLS pipeline II=1
        dtype gates_tmp=0, gates_tmp2=0, gates_tmp3=0, gates_tmp4=0;
        for (int k=0; k<m2/4; k++) {
            gates_tmp += inputs[k] * w_all[k][j];
        }
        for (int k=m2/4; k<m2/2; k++) {
            gates_tmp2 += inputs[k] * w_all[k][j];
        }
        for (int k=m2/2; k<(m2/2 + m2/4); k++) {
            gates_tmp3 += inputs[k] * w_all[k][j];
        }
        for (int k=(m2/2 + m2/4); k<m2; k++) {
            gates_tmp4 += inputs[k] * w_all[k][j];
        }
        gates[j] = gates_tmp + gates_tmp2 + gates_tmp3 + gates_tmp4;
    }

    for (int j=0; j<m; j++){
#pragma HLS unroll factor=32
#pragma HLS pipeline II=1
        ff[j] = (dtype)(1 + exp((dtype)-(gates[j+2*m]+1)));
        fi[j] = (dtype)(1 + exp((dtype)-(gates[j])));
        fo[j] = (dtype)(1 + exp((dtype)-(gates[j+3*m])));
    }

    for (int j=0; j<m; j++){
#pragma HLS unroll factor=32
#pragma HLS pipeline II=1
        fC[j] = (dtype) tanhf((dtype) gates[j+m]);
    }

    for (int j=0; j<m; j++){
#pragma HLS unroll factor=32
#pragma HLS pipeline II=1
        ff2[j] = (dtype)1.0/ff[j];
        fi2[j] = (dtype)1.0/fi[j];
        fo2[j] = (dtype)1.0/fo[j];
    }

    for (int j=0; j<m; j++){
#pragma HLS unroll factor=32
#pragma HLS pipeline II=1
        dtype temp1 = c[j] * ff2[j];
        dtype temp2 = fi2[j] * fC[j];
        arr[j] = temp1 + temp2;
    }
    for (int j=0; j<m; j++){
#pragma HLS unroll factor=32
#pragma HLS pipeline II=1
        c[j] = (dtype) tanhf((dtype)(arr[j]));
    }
    for (int j=0; j<m; j++){
#pragma HLS unroll factor=32
#pragma HLS pipeline II=1
        h[j] = c[j] * fo2[j];
    }

    // simple output (example)
    h_out = h[0];
}
