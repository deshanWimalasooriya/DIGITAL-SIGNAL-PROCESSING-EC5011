clc; clear; close all;

%% Parameters
Fs = 8000;        % Sampling frequency
N = 9;            % Filter order
Fc = 3000;        % Cutoff frequency (Hz)

%% Design FIR High-pass Filter using fir1 (rectangular window)
Wn = Fc / (Fs/2);                 % Normalized cutoff (0 to 1)
b = fir1(N-1, Wn, 'high');        % High-pass filter using rectangular window

%% Frequency Response
Nfft = 4096;
[H, f] = freqz(b, 1, Nfft, Fs);   % Frequency response

%% Plot
figure;
subplot(2,1,1);
plot(f, 20*log10(abs(H)));
title('Magnitude Response of FIR High-pass Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
xlim([0 Fs/2]);

subplot(2,1,2);
plot(f, angle(H));
title('Phase Response of FIR High-pass Filter');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
grid on;
xlim([0 Fs/2]);
