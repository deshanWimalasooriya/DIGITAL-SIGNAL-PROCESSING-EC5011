%Sampling info
fs = 4000;
T = 1/fs;
N = 1024;
t = (0:N-1)*T;
%signal definition
x = cos(2*pi*100*t)+cos(2*pi*500*t)+cos(2*pi*2000*t)+cos(2*pi*2750*t);
y = 0.2 + x;

%----- Frequency Domain (FFT)----
Y = fft(y);
Y_mag = abs(Y)/N;
Y_half = Y_mag(1:N/2);
f = (0:N/2-1)*(fs/N);
w = 2*pi*f/fs; 
f_norm = f/fs;   

%-------Subplots-------
figure;
%------ Time Domain Plot-----
subplot(4,1,1);
plot(t*1000, y);
xlabel('Time (ms)');
ylabel('y[n]');
title('Time Domain Signal y[n]');
grid on;

%plot in Hz
subplot(4,1,2)
plot(f,Y_half);
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');
title('Magnitude Spectrum of y[n] (Hz)');
grid on;

% Frequency Spectrum (Radians/sample)
subplot(4,1,3);
plot(w, Y_half);
xlabel('Frequency (Radians/sample)');
ylabel('|Y(\omega)|');
title('Spectrum in Radians/sample');
grid on;

% Frequency Spectrum (Normalized)
subplot(4,1,4);
plot(f_norm, Y_half);
xlabel('Normalized Frequency');
ylabel('|Y(f)|');
title('Normalized Spectrum');
grid on;


%Plot Info
N = length(x);
X = abs(fft(x));
F = (0:N-1)*(fs/N);

% Plot full frequency spectrum
figure;
plot(F, X);
title('Full Spectrum of x[n]');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
xlim([0 fs]);  % Plot full 0 to fs
