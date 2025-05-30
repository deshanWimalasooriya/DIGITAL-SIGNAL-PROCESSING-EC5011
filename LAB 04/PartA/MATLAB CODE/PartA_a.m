%% Part (a) - Magnitude Spectra in Hz
clc; clear;

% Parameters
fs = 15000;                  % Original sampling frequency
N = 2048;                    % Number of samples
t = (0:N-1)/fs;              % Time vector

% Input signal
x = 3000*sin(2*pi*1000*t) + 2000*sin(2*pi*2000*t) + 1000*sin(2*pi*5500*t);
f = linspace(-fs/2, fs/2, N);

%% 1. Downsampling by 3 (without filtering)
xd1 = x(1:3:end);
f1 = linspace(-fs/6, fs/6, length(xd1));

figure;
subplot(2,1,1);
plot(f, abs(fftshift(fft(x))));
title('Original Signal Spectrum');
xlabel('Frequency (Hz)'); ylabel('|X(f)|');

subplot(2,1,2);
plot(f1, abs(fftshift(fft(xd1, length(xd1)))));
title('Downsampled without Filtering');
xlabel('Frequency (Hz)'); ylabel('|X_d1(f)|');

%% 2. Downsampling by 3 (with filtering)
lpf = fir1(63, 1/3);             % Low-pass FIR filter
xf = filter(lpf, 1, x);          
xd2 = xf(1:3:end);
f2 = linspace(-fs/6, fs/6, length(xd2));

figure;
subplot(3,1,1);
plot(f, abs(fftshift(fft(x))));
title('Original Signal Spectrum');
xlabel('Frequency (Hz)'); ylabel('|X(f)|');

subplot(3,1,2);
plot(f, abs(fftshift(fft(xf))));
title('Filtered Signal');
xlabel('Frequency (Hz)'); ylabel('|X_f(f)|');

subplot(3,1,3);
plot(f2, abs(fftshift(fft(xd2, length(xd2)))));
title('Downsampled with Filtering');
xlabel('Frequency (Hz)'); ylabel('|X_d2(f)|');

%% 3. Upsampling by 3 (with filtering)
xu = upsample(x, 3);
h_interp = fir1(63, 1/3);
xu_filtered = filter(h_interp, 1, xu);
f3 = linspace(-3*fs/2, 3*fs/2, length(xu_filtered));

figure;
subplot(3,1,1);
plot(f, abs(fftshift(fft(x))));
title('Original Signal Spectrum');
xlabel('Frequency (Hz)'); ylabel('|X(f)|');

subplot(3,1,2);
plot(f3, abs(fftshift(fft(xu, length(xu)))));
title('Up-sampled (Zero Insertion)');
xlabel('Frequency (Hz)'); ylabel('|X_u(f)|');

subplot(3,1,3);
plot(f3, abs(fftshift(fft(xu_filtered, length(xu_filtered)))));
title('Up-sampled with Filtering');
xlabel('Frequency (Hz)'); ylabel('|X_u_f(f)|');

%% 4. Change sampling rate to 6 kHz
[xr, ~] = resample(x, 6, 15);    % From 15kHz to 6kHz
f4 = linspace(-3000, 3000, length(xr));

figure;
subplot(2,1,1);
plot(f, abs(fftshift(fft(x))));
title('Original Signal Spectrum (15 kHz)');
xlabel('Frequency (Hz)'); ylabel('|X(f)|');

subplot(2,1,2);
plot(f4, abs(fftshift(fft(xr, length(xr)))));
title('Resampled Signal Spectrum (6 kHz)');
xlabel('Frequency (Hz)'); ylabel('|X_r(f)|');
