% Sampling setup
fs = 4000;          % Sampling frequency
n_x = 0:399;        % 400 samples for x[n]
n_p = 0:3599;       % 3600 samples for p[n]

% x[n]: same as in Q1
x = cos(2*pi*100*n_x/fs) + cos(2*pi*500*n_x/fs) + ...
    cos(2*pi*2000*n_x/fs) + cos(2*pi*2750*n_x/fs);

% p[n]: two sinusoids at 900 Hz and 1200 Hz
p = sin(2*pi*900*n_p/fs) + sin(2*pi*1200*n_p/fs);

% Construct q[n]: x followed by p
q = [x, p];                 % 4000 samples total
n_q = 0:length(q)-1;

% Plot time domain
figure;
subplot(2,1,1);
plot(n_q, q);
xlabel('n'); ylabel('q[n]');
title('Time-Domain Signal q[n]');

% Frequency domain
Q = abs(fft(q));
f = (0:length(q)-1)*fs/length(q);
subplot(2,1,2);
plot(f, Q);
xlabel('Frequency (Hz)'); ylabel('|Q(f)|');
title('Magnitude Spectrum of q[n]');
xlim([0 fs/2]);  % Plot up to Nyquist

