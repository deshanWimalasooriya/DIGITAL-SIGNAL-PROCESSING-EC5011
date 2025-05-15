%WIMALASOORIYA G.H.N.D.
%2022E039

% ------------------------------
% PART 1: Compute hd[n]
% ------------------------------
fs = 8000;                  % Sampling frequency in Hz
N = 9;                      % Filter length (odd, for symmetry)
M = (N-1)/2;                % Center of symmetry
n = 0:N-1;                  % Sample indices
n_shifted = n - M;          % Centered indices (for symmetry)

% Ideal cutoff frequency: π/3
wc = pi/3;

% Initialize hd[n]
hd = zeros(1, N);

% Compute ideal impulse response
for i = 1:N
    if n_shifted(i) == 0
        hd(i) = wc / pi;    % hd[0] = wc/pi
    else
        hd(i) = sin(wc * n_shifted(i)) / (pi * n_shifted(i));
    end
end

% ------------------------------
% PART 2: Apply Rectangular Window
% ------------------------------
w = ones(1, N);             % Rectangular window
h = hd .* w;                % Apply window to get FIR coefficients

% ------------------------------
% PART 3: Normalize and Plot Using FFT (No freqz)
% ------------------------------
% Normalize for unity gain at DC
h_norm = h / sum(h);

% FFT settings
Nfft = 4096;
H_fft = fft(h_norm, Nfft);
f = (0:Nfft-1) * (fs/Nfft);         % Frequency axis in Hz

% Magnitude and Phase
mag_db = 20 * log10(abs(H_fft));   % Magnitude in dB
phase_rad = unwrap(angle(H_fft));  % Unwrapped phase in radians

% Plot magnitude response
figure;
subplot(2,1,1);
plot(f, mag_db);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response (FFT)');
grid on;
xlim([0 fs/2]);

% Plot phase response
subplot(2,1,2);
plot(f, phase_rad);
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
title('Phase Response (FFT)');
grid on;
xlim([0 fs/2]);

% ------------------------------
% Display Filter Coefficients
% ------------------------------
disp('Impulse response hd[n]:');
disp(hd);

disp('Windowed (FIR) coefficients h[n]:');
disp(h);

disp('Normalized FIR coefficients h_norm[n]:');
disp(h_norm);


