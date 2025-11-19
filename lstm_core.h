// lstm_core.h - header for HLS optimized LSTM kernel
#ifndef LSTM_CORE_H
#define LSTM_CORE_H

#include <ap_int.h>
#include <hls_stream.h>
#include <cmath>

typedef float dtype;

void lstm_core(dtype inputs[], dtype w_all[][256], dtype &h_out, int m, int m2);

#endif
