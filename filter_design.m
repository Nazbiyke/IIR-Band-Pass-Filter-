% IIR Bandpass Filter Design with Phase Equalization
clf;
clc;
clear;

% Part 1: Design IIR Bandpass Butterworth Filter

% Filter specifications:
%maximum attenuation in Passband  = 1.5 dB;           
%minimum attenuation in SB = 31 dB
Fp1 = 4000;      % Lower passband edge (4 kHz)
Fp2 = 5000;      % Upper passband edge (5 kHz)
Fs1 = 3500;      % Lower stopband edge (3.5 kHz)
Fs2 = 5500;      % Upper stopband edge (5.5 kHz)
Sf = 22000;      % Sampling frequency (22 kHz)

% Normalized frequencies
wp = [Fp1, Fp2]/(Sf/2);
ws = [Fs1, Fs2]/(Sf/2);

% Design Butterworth bandpass filter
[N, Wn] = buttord(wp, ws, 1.5, 31);
[b1, a1] = butter(N, Wn, 'bandpass');  

% Frequency response
w = pi*(0:0.001:1); % Normalized frequency vector
h1 = freqz(b1, a1, w);
g1 = grpdelay(b1, a1, w); % group delay of the bandpass filter

% Plot poles and zeros
figure(1);
zplane(b1, a1);
title('Pole-Zero Plot of Bandpass Filter');

% Plot magnitude response
figure(2);
plot(w/pi, 20*log10(abs(h1))); grid on;
xlabel('\omega /\pi'); ylabel('Gain (dB)');
title('Bandpass Filter Frequency Response');


% Part 2: Group Delay Equalization with All-Pass

% Design all-pass filter for equalization
N_ap = 4; % All-pass filter order
indx = round(wp / 0.001) + 1; % Indices of the pass-band frequencies 
F = w(indx(1): indx(2))/pi; % Normalized frequencies
edges = [F(1) F(end)]; % Band edges

% Desired group delay
Gd = max(g1)-g1(indx(1):indx(2)); 

% Design all-pass filter
[b2, a2] = iirgrpdelay(N_ap, F, edges, Gd);

% All-pass frequency response calculation
h2 = freqz(b2, a2, w);
g2 = grpdelay(b2, a2, w);

% Plot of APF frequency response magnitude, phase and group delay
figure(3)
subplot(3,1,1)
plot(w/pi, abs(h2)); grid on;
ylabel('magnitude response');
title('All-Pass Filter');

subplot(3,1,2)
plot(w/pi, unwrap(angle(h2))); grid on;
ylabel('phase response (rad)');

subplot(3,1,3)
plot(w/pi, g2); grid on;
ylabel('group delay (samples)');
xlabel('Normalized Frequency (\times\pi rad/sample)');


% Cascade of the two filters
b = conv(b1, b2); %product of numerator polynomials
a = conv(a1, a2); % product of denominators polynomials
h = freqz(b, a, w); % compute DTFT
g = grpdelay(b, a, w); % compute group delay

% Plot of resulting filter 
figure(4)
subplot(4,1,1)
plot(w/pi, abs(h)); grid on;
ylabel('magnitude response');
title('Cascaded System: Bandpass + All-Pass');
subplot(4,1,2)
plot(w/pi, unwrap(angle(h))); grid on;
ylabel('phase response (rad)');
subplot(4,1,3)
plot(w/pi, g); grid on;
ylabel('group delay (samples)');
xlabel('Normalized Frequency (\times\pi rad/sample)');

