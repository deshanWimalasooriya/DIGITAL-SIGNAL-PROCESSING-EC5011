clc; clear; close all;

%% Parameters
Fs = 12000;              % Sampling frequency (Hz)
t = 0:1/Fs:0.1;           % Time vector (0.1 seconds)

%% Composite Signal
x = sin(2*pi*600*t) + ...
    sin(2*pi*1100*t) + ...
    sin(2*pi*2300*t) + ...
    sin(2*pi*5000*t);

%% FIR Filter from Part 03 (using same specs)
firFilt = designfilt('lowpassfir', ...
    'PassbandFrequency', 2000, ...
    'StopbandFrequency', 3500, ...
    'PassbandRipple', 0.1, ...
    'StopbandAttenuation', 40, ...
    'SampleRate', Fs);

%% Filtering the Signal
y = filter(firFilt, x);   % Can also use conv(y, b, 'same') for convolution

%% Frequency Domain Analysis
N = 4096;
X = abs(fft(x, N));
Y = abs(fft(y, N));
f = (0:N-1)*(Fs/N);       % Frequency axis (Hz)

% Normalize FFT for magnitude (optional, to match scale)
X = X / max(X);
Y = Y / max(Y);

%% Plot
figure;
subplot(2,1,1);
plot(f, 20*log10(X));
title('Input Signal - Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0 Fs/2]);
grid on;

subplot(2,1,2);
plot(f, 20*log10(Y));
title('Filtered Output Signal - Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0 Fs/2]);
grid on;
