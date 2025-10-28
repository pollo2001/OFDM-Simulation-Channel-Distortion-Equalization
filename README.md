# 🌐 OFDM Simulation & Equalization in MATLAB

A MATLAB project demonstrating the end-to-end OFDM pipeline, from symbol generation and channel distortion to preamble-based equalization.

---

## Project Overview

This script simulates an OFDM (Orthogonal Frequency-Division Multiplexing) communication system. It explains the full MATLAB pipeline, including:

* Symbol generation with guard intervals & cyclic prefixes
* Channel effects, convolution, and distortion
* Preamble-based channel estimation
* Frequency-domain equalization
* Preamble detection and rotation estimation

### 1️⃣ Section A: OFDM Symbol Generation & Guard Interval
* **Purpose:** Create 128-point OFDM symbols with 32-sample guard intervals.
* **Concepts:** OFDM modulation, guard intervals, cyclic prefix.

### 2️⃣ Section B: FFT Transform Segments
* **Purpose:** Analyze individual OFDM symbol frequency content.
* **Concepts:** Symbol-wise FFT, frequency-domain inspection.

### 3️⃣ Section C: Channel Distortion Simulation
* **Purpose:** Model multipath or linear channel distortions.
* **Concepts:** Linear convolution, channel modeling, frequency response.

### 4️⃣ Section D: Cyclic Prefix Processing
* **Purpose:** Preserve OFDM orthogonality under a multipath channel.
* **Concepts:** Cyclic prefix, ISI mitigation, symbol recovery.

### 5️⃣ Section E: Preamble & Channel Estimation
* **Purpose:** Estimate the channel response using a known preamble.
* **Concepts:** Channel estimation, frequency-domain equalization.

### 6️⃣ Section F: Equalizer & Data Extraction
* **Purpose:** Extract data symbols, remove cyclic prefix, apply FFT, and equalize.
* **Concepts:** Cyclic prefix removal, FFT-based equalization, constellation visualization.

### 7️⃣ Section G: Special Preamble & Rotation Estimation
* **Purpose:** Detect the preamble and estimate phase rotation using cross-correlation.
* **Concepts:** Cross-correlation detection, phase rotation estimation, preamble synchronization.

---

## 🚀 Getting Started

### Prerequisites

* MATLAB R2024a or newer
* MATLAB DSP Toolbox

### Usage

1.  Open the project in MATLAB.
2.  Run the main script (e.g., `FINAL161C.m`).
3.  Observe the generated plots for constellations and channel response.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
