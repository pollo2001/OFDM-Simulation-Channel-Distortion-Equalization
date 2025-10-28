🌐 OFDM Simulation, Channel Distortion & Equalization

This script explains the MATLAB OFDM pipeline, including:
- Symbol generation with guard intervals & cyclic prefixes
- FFT-based visualization of segments
- Channel effects, convolution, and equalization
- Constellation analysis pre- and post-equalization

---

1️⃣ OFDM Symbol Generation & Guard Interval (Section A)

- 🎯 Purpose: Create 128-point OFDM symbols with 32-sample guard intervals.
- 🔧 Code Choices:
    - Random QPSK-like symbols mapped into frequency bins.
    - IFFT to generate time-domain OFDM signals.
    - Zero-padding and cyclic prefix prepended for ISI mitigation.
- DSP Concepts: OFDM modulation, guard intervals, cyclic prefix.

2️⃣ FFT Transform Segments (Section B)

- 🎯 Purpose: Analyze individual OFDM symbol frequency content.
- 🔧 Code Choices:
    - Take FFT of time-domain symbols, ignoring the guard interval.
    - Plot real/imaginary components and scatter to visualize spectral distribution.
- DSP Concepts: Symbol-wise FFT, frequency-domain inspection.

3️⃣ Channel Distortion Simulation (Section C)

- 🎯 Purpose: Model multipath or linear channel distortions.
- 🔧 Code Choices:
    - Convolution with a complex channel impulse response.
    - Observe the frequency-domain impact on transmitted symbols.
- DSP Concepts: Linear convolution, channel modeling, frequency response.

4️⃣ Cyclic Prefix Processing (Section D)

- 🎯 Purpose: Preserve OFDM orthogonality under a multipath channel.
- 🔧 Code Choices:
    - Insert a cyclic prefix before the channel.
    - Compare FFT segments with and without CP.
- DSP Concepts: Cyclic prefix, ISI mitigation, symbol recovery.

5️⃣ Preamble & Channel Estimation (Section E)

- 🎯 Purpose: Estimate the channel response using a known preamble.
- 🔧 Code Choices:
    - FFT of the preamble and the received signal.
    - Divide the received preamble by the transmitted preamble for a channel estimate.
    - Zero out edge bins to remove noise.
- DSP Concepts: Channel estimation, frequency-domain equalization.

---

🌟 OFDM Equalization & Preamble Detection

This script explains Sections F & G from the MATLAB OFDM project:
- Section F: Extracts the data portion after the preamble, removes the cyclic prefix, performs FFT and equalization, and visualizes constellations.
- Section G: Creates a special preamble, simulates signal rotation and delay, detects the preamble with cross-correlation, and estimates the rotation rate.

---

6️⃣ Equalizer & Data Extraction (Section F)

- 🎯 Purpose: Extract data symbols after the preamble, remove the cyclic prefix, apply FFT, and equalize using the estimated channel response.
- 🔧 Code Choices:
    - `data_start` identifies the first sample of actual data after preambles.
    - Reshape received samples into symbols, removing the cyclic prefix.
    - FFT of each symbol is divided by the preamble-based channel estimate `H_est`.
    - Only active data carriers are extracted and plotted.
- DSP Concepts: Cyclic prefix removal, FFT-based equalization, data carrier extraction, constellation visualization.

7️⃣ Special Preamble & Rotation Estimation (Section G)

- 🎯 Purpose: Create a known frequency-domain preamble, simulate signal rotation and noise, detect the preamble, and estimate phase rotation.
- 🔧 Code Choices:
    - `special_bins` defines only certain active subcarriers in the preamble.
    - IFFT generates the time-domain preamble.
    - Test signal concatenates zero-padding, preamble, and OFDM symbols; noise and rotation are added.
    - Cross-correlation between the received signal and preamble identifies the start of the preamble.
    - Phase rotation is estimated via recursive smoothing of angles.
    - Visualizations show cross-correlation, auto-correlation, ratio, and estimated rotation rate.
- DSP Concepts: Frequency-domain preamble, cross-correlation detection, phase rotation estimation, preamble synchronization.

---

📝 Notes

- Guard intervals prevent Inter-Symbol Interference (ISI); the cyclic prefix preserves orthogonality.
- FFT segments visualize the frequency bins of each OFDM symbol.
- Convolution simulates channel distortion; equalization corrects it.
- Constellation plots visually validate symbol recovery.
