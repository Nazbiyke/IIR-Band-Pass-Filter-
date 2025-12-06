# IIR Band-Pass Filter Design and Group Delay Equalization (MATLAB)

This project implements a complete digital filter design workflow in MATLAB, including the design of an IIR band-pass Butterworth filter and the phase equalization of its group delay using an all-pass filter. The work is based on requirements from a university final exam in Digital Signal Processing.

📌 Project Overview

The task is divided into two major parts:

## 1. IIR Band-Pass Filter Design (Butterworth)

-A digital band-pass filter is designed according to the following specifications:

-Passband edge frequencies: 4 kHz and 5 kHz

-Stopband edge frequencies: 3.5 kHz and 5.5 kHz

-Passband ripple: ≤ 1.5 dB

-Stopband attenuation: ≥ 31 dB

-Sampling frequency: 22 kHz

Using these constraints, the script:

Designs an IIR band-pass Butterworth filter

Computes its transfer function H₁(z)

Plots poles and zeros

Computes and plots the magnitude frequency response

## 2. Group Delay Equalization Using an All-Pass Filter

Because IIR filters do not have linear phase, the second part of the project implements a group-delay equalization method:

-Designs an all-pass filter with transfer function H₂(z)

-Cascades it with the original filter

-Produces and plots:

  - Magnitude response of the cascade

  - Phase response

  - Group delay (showing improvement in the passband)


🛠 Methods and MATLAB Functions Used

The project makes use of several DSP and Signal Processing Toolbox features, such as:

buttord, butter — filter order and coefficient calculation

freqz — frequency-response analysis

grpdelay — group delay computation

zplane — pole-zero visualization

Custom all-pass filter design based on group-delay matching

📊 Results Summary

The designed Butterworth filter satisfies the amplitude specifications for passband ripple and stopband attenuation.

The all-pass compensator significantly flattens the group delay within the 4–5 kHz passband.

Final plots demonstrate an improved phase linearity in the cascade filter.


🚀 How to Run

Open MATLAB

Add the project folder to your path

Run:

filter_design


Resulting plots will appear automatically.
