clc; clear; close all;

%% -------------------------------
% STEP 1: Ideal Impulse Response hd[n]
% H(θ) = 1 for |θ| ≤ π/3 → sinc function in time domain
% hd[n] = (1/π) * ∫_{-π/3}^{π/3} e^(jθn) dθ = sin(πn/3)/(πn)

N = 9;                   % Filter length
M = (N - 1)/2;           % Half-length for symmetric FIR
n = -M:M;                % Time indices

% Ideal impulse response hd[n]
hd = sin(pi*n/3) ./ (pi*n);  
hd(M+1) = 1/3;           % Handle n = 0 separately to avoid NaN

%% -------------------------------
% STEP 2: Apply Rectangular Window (just keep hd as it is)
h = hd;                 % Rectangular window = 1

%% -------------------------------
% STEP 3: Normalize the Filter (DC gain = 1)
h = h / sum(h);         % Normalize DC gain

% Frequency response using FFT (without freqz)
Nfft = 4096;
H_fft = fft(h, Nfft);
H_mag = 20*log10(abs(H_fft));  % dB scale
H_phase = angle(H_fft);

f = (0:Nfft-1)*(8000/Nfft);    % Frequency axis in Hz

% Plot magnitude and phase
figure;
subplot(2,1,1);
plot(f, H_mag);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Normalized FIR Filter - Magnitude (FFT)');
xlim([0 4000]); grid on;

subplot(2,1,2);
plot(f, H_phase);
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
title('Normalized FIR Filter - Phase (FFT)');
xlim([0 4000]); grid on;

%% -------------------------------
% STEP 4: FIR Design using fir1 (Rectangular Window)
Wn = (1/3);                      % Normalized cutoff π/3 = 1/3 of π
b_fir1 = fir1(N-1, Wn, 'low');   % FIR low-pass using rectangular window

% Frequency response
[H1, f1] = freqz(b_fir1, 1, Nfft, 8000);
figure;
subplot(2,1,1);
plot(f1, 20*log10(abs(H1)));
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('FIR1 Filter - Magnitude Response');
xlim([0 4000]); grid on;

subplot(2,1,2);
plot(f1, angle(H1));
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
title('FIR1 Filter - Phase Response');
xlim([0 4000]); grid on;

%% -------------------------------
% STEP 5: Design using firpm (Parks-McClellan)
% Bands: [0 2666 3333 4000] Hz (normalized)
f_p = 2000; f_s = 2666;
bands = [0 2666 3333 4000]/(8000/2);
desired = [1 1 0 0];
b_pm = firpm(N-1, bands, desired);

% Frequency response
[H2, f2] = freqz(b_pm, 1, Nfft, 8000);
figure;
subplot(2,1,1);
plot(f2, 20*log10(abs(H2)));
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('FIRPM Filter - Magnitude Response');
xlim([0 4000]); grid on;

subplot(2,1,2);
plot(f2, angle(H2));
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
title('FIRPM Filter - Phase Response');
xlim([0 4000]); grid on;

%% -------------------------------
% STEP 6: Comparison of Magnitude Responses
figure;
plot(f, H_mag, 'LineWidth', 1.2); hold on;
plot(f1, 20*log10(abs(H1)), '--', 'LineWidth', 1.2);
plot(f2, 20*log10(abs(H2)), ':', 'LineWidth', 1.2);
legend('FFT (Manual)', 'fir1', 'firpm');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Comparison of Magnitude Responses');
xlim([0 4000]);
grid on;
