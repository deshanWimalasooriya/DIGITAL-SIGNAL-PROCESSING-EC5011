%% Part (b) - Magnitude Spectra in rad/sample
clc; clear;

fs = 15000;
N = 2048;
t = (0:N-1)/fs;
x = 3000*sin(2*pi*1000*t) + 2000*sin(2*pi*2000*t) + 1000*sin(2*pi*5500*t);
w = linspace(-pi, pi, N);

%% Task 2: Downsampling by 3 with filtering
lpf = fir1(63, 1/3);
xf = filter(lpf, 1, x);
xd2 = xf(1:3:end);
w_ds = linspace(-pi, pi, length(xd2));

figure;
subplot(3,1,1);
plot(w, abs(fftshift(fft(x))));
title('Original Signal Spectrum (rad/sample)');
xlabel('\omega (rad/sample)'); ylabel('|X(e^{j\omega})|');

subplot(3,1,2);
plot(w, abs(fftshift(fft(xf))));
title('Filtered Signal Spectrum (rad/sample)');
xlabel('\omega (rad/sample)'); ylabel('|X_f(e^{j\omega})|');

subplot(3,1,3);
plot(w_ds, abs(fftshift(fft(xd2, length(xd2)))));
title('Downsampled with Filtering (rad/sample)');
xlabel('\omega (rad/sample)'); ylabel('|X_d(e^{j\omega})|');

%% Task 3: Upsampling by 3 with filtering
xu = upsample(x, 3);
h_interp = fir1(63, 1/3);
xu_filtered = filter(h_interp, 1, xu);
w3 = linspace(-pi, pi, length(xu_filtered));

figure;
subplot(3,1,1);
plot(w, abs(fftshift(fft(x))));
title('Original Signal Spectrum (rad/sample)');
xlabel('\omega (rad/sample)'); ylabel('|X(e^{j\omega})|');

subplot(3,1,2);
plot(w3, abs(fftshift(fft(xu, length(xu)))));
title('Upsampled Spectrum (rad/sample)');
xlabel('\omega (rad/sample)'); ylabel('|X_u(e^{j\omega})|');

subplot(3,1,3);
plot(w3, abs(fftshift(fft(xu_filtered, length(xu_filtered)))));
title('Upsampled and Filtered Spectrum (rad/sample)');
xlabel('\omega (rad/sample)'); ylabel('|X_u_f(e^{j\omega})|');
