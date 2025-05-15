% Specifications
fs = 12000;             % Sampling frequency in Hz
fp = 2000;              % Passband frequency in Hz
fsb = 3500;             % Stopband frequency in Hz
Rp = 0.1;               % Passband ripple in dB
Rs = 40;                % Stopband attenuation in dB

% Normalized frequencies (0 to 1, with 1 = Nyquist frequency)
Wp = fp / (fs/2);
Ws = fsb / (fs/2);

% Frequency response resolution
Nfreq = 1024;
f = linspace(0, fs/2, Nfreq);

% ------------------------------
% 1. Butterworth Filter
% ------------------------------
[n_butt, Wn_butt] = buttord(Wp, Ws, Rp, Rs);
[b_butt, a_butt] = butter(n_butt, Wn_butt);
[H_butt, w] = freqz(b_butt, a_butt, Nfreq, fs);

% ------------------------------
% 2. Chebyshev Type I
% ------------------------------
[n_cheby1, Wn_cheby1] = cheb1ord(Wp, Ws, Rp, Rs);
[b_cheby1, a_cheby1] = cheby1(n_cheby1, Rp, Wn_cheby1);
H_cheby1 = freqz(b_cheby1, a_cheby1, Nfreq, fs);

% ------------------------------
% 3. Chebyshev Type II
% ------------------------------
[n_cheby2, Wn_cheby2] = cheb2ord(Wp, Ws, Rp, Rs);
[b_cheby2, a_cheby2] = cheby2(n_cheby2, Rs, Wn_cheby2);
H_cheby2 = freqz(b_cheby2, a_cheby2, Nfreq, fs);

% ------------------------------
% 4. Elliptic Filter
% ------------------------------
[n_ellip, Wn_ellip] = ellipord(Wp, Ws, Rp, Rs);
[b_ellip, a_ellip] = ellip(n_ellip, Rp, Rs, Wn_ellip);
H_ellip = freqz(b_ellip, a_ellip, Nfreq, fs);

% ------------------------------
% Plot Magnitude Responses
% ------------------------------
figure;

plot(f, 20*log10(abs(H_butt)), 'b', 'LineWidth', 1.5); hold on;
plot(f, 20*log10(abs(H_cheby1)), 'r', 'LineWidth', 1.5);
plot(f, 20*log10(abs(H_cheby2)), 'g', 'LineWidth', 1.5);
plot(f, 20*log10(abs(H_ellip)), 'k', 'LineWidth', 1.5);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response of IIR Filters');
legend('Butterworth', 'Chebyshev I', 'Chebyshev II', 'Elliptic');
xlim([0 fs/2]);
ylim([-100 5]);
