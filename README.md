# LSTM-Based-ECG-Classification-for-Continuous-Monitoring-on-Personal-Wearable-Devices
LSTM-based ECG classification system for continuous cardiac monitoring on wearable devices. Combines heartbeat segmentation, multi-level wavelet transform, and optimized LSTM architectures for efficient arrhythmia detection on low-power hardware using Verilog, HLS, and MATLAB.
**Objective:** A novel electrocardiogram (ECG) classification algorithm is proposed for continuous cardiac monitoring on wearable devices with limited processing capacity. 
Methods: The proposed solution employs a novel architecture consisting of a wavelet transform and multiple long short-term memory (LSTM) recurrent neural networks.

---

## 📌 System Overview

### ⭐ 1. Segmentation
ECG signals are segmented into heartbeats based on R-peak detection.  
Each segment includes:
- **0.25s before** the R peak  
- **0.45s after** the R peak  

This yields the signal window **Xecg** used in further processing.

---

## ⭐ 2. Wavelet-Based Feature Extraction (DWT)

To capture both time and frequency information of the non-stationary ECG signal, a **4-level db2 Discrete Wavelet Transform** is applied.  
This produces:
- D4  
- D3  
- D2  
- D1  

These represent different ECG frequency bands.  
Hardware implementation includes:
- High-pass & Low-pass filters  
- Downsampling modules  
- 3-stage DWT architecture  
- Complete inverse DWT (reconstruction) pipeline  

---

## ⭐ 3. LSTM Model Architectures

### **Model α – Dual-Branch LSTM**
Two branches operate in parallel:
- **Branch 1:** Xrr + Xecg  
- **Branch 2:** Xrr + Xw (wavelet coefficients)

Each branch extracts high-level features via LSTM layers.  
Outputs are concatenated and fed to a fully connected layer to classify arrhythmia types.

---

### **Model β – Single-Branch LSTM**
- Xecg (downsampled) + Xrr + Xw are concatenated  
- PCA reduces dimensionality  
- A single LSTM branch extracts features  
- Fully connected layer produces final classification  

---

## ⭐ 4. Hardware Implementations

### 🔹 Verilog Modules
- Multi-level DWT filters  
- High/low-pass reconstruction filters  
- Upsampling/downsampling logic  
- Matrix multiplication module for FC and LSTM layers  

### 🔹 High-Level Synthesis (HLS)
Optimized LSTM gate computations using:
- Pipelining (II=1)  
- Loop unrolling  
- Parallel multiply-accumulate operations  

Designed for real-time inference on FPGA-based wearables.

---
## 📊 Applications
- Wearable ECG patches  
- Real-time arrhythmia monitoring  
- Low-power biomedical AI systems  
- Edge-AI health monitoring devices  

---
MATLAB scripts: run matlab/segmentation.m on your ECG data to produce segments, then matlab/dwt_wavelet.m per segment to get wavelet features. Save processed features into matlab/train_data.mat for lstm_training.m.

Verilog modules provided are skeletons: high/low-pass filters, downsample/upsample, and reconstruct filters need real coefficients and accurate sample-rate logic (these depend on your hardware design).

HLS code is a template using the pragmas from your report — tune m, m2, memory access patterns, and types for your target platform (Vivado HLS / Intel HLS).

## ✨ Author
**Zunaira Khalid**  
Biomedical Signal Processing • Embedded AI • Deep Learning  



