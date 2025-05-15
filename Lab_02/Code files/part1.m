% WIMALASOORIYA G.H.N.P.D.
% 2022E039

% PART 01
% ---------------------------

% Define numerator and denominator
num = [1 0 10 3 28];
den = [1 0 0.35 -0.35 0.425];

% Plot Pole-Zero Map
figure; % <-- ADD THIS to open a new figure window
zplane(num, den);
title('Pole-Zero Map of H(z)');
xlabel('Real part');
ylabel('Imaginary part');
grid on;

% Define coefficients
b = [1 0 10 3 28];       % Numerator coefficients (highest to lowest power)
a = [1 0 0.35 -0.35 0.425]; % Denominator coefficients

% Number of samples
N = 50; % length of impulse response

% Generate impulse input
x = zeros(1, N);
x(1) = 1; % impulse at n=0

% Initialize output
y = zeros(1, N);

% Manual filtering using the difference equation
for n = 1:N
    % Feedforward part (numerator)
    for k = 1:length(b)
        if n-k+1 > 0
            y(n) = y(n) + b(k) * x(n-k+1);
        end
    end
    % Feedback part (denominator)
    for k = 2:length(a)
        if n-k+1 > 0
            y(n) = y(n) - a(k) * y(n-k+1);
        end
    end
end

% Plot the impulse response
figure; % <-- ADD THIS also if you want impulse response in a new figure
stem(0:N-1, y, 'filled');
title('Impulse Response of H(Z)');
xlabel('n');
ylabel('h[n]');
grid on;

%---------------------------------------------------------
% Plot Magnitude and Phase Response using the Impulse Response
% Take FFT of the impulse response
Y = fft(y, 512); % 512-point FFT for better resolution

% Frequency axis
f = linspace(0, 1, 512); % Normalized frequency (0 to 1 corresponds to 0 to π rad/sample)

% Plot magnitude response
figure;
plot(f, abs(Y));
title('Magnitude Response from Impulse Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('|H(e^{j\omega})|');
grid on;

% Plot phase response
figure;
plot(f, angle(Y));
title('Phase Response from Impulse Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (radians)');
grid on;

%---------------------------------------------------------

%---------------------------------------------------------
%Find Frequency Response Directly using freqz (without impulse response)

% Directly find the frequency response using freqz
[H, w] = freqz(b, a, 512); % 512 points

% Plot magnitude response
figure;
plot(w/pi, abs(H));
title('Magnitude Response using freqz');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('|H(e^{j\omega})|');
grid on;

% Plot phase response
figure;
plot(w/pi, angle(H));
title('Phase Response using freqz');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (radians)');
grid on;

%---------------------------------------------------------

