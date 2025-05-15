% WIMALASOORIYA G.H.N.P.D.
% 2022E039

% Define Zeros
z = [0.7+0.2j; 0.7-0.2j; -0.4+0.4j; -0.4-0.4j];

% Poles (none given, so empty)
p = [];

% Gain (you can choose 1 unless otherwise specified)
k = 1;

% Get transfer function coefficients
[b, a] = zp2tf(z, p, k);

% Display the numerator and denominator
disp('Numerator coefficients (b):');
disp(b);

disp('Denominator coefficients (a):');
disp(a);

% Pole-Zero Plot
figure;
zplane(b, a);
title('Pole-Zero Map of the Given Filter');
xlabel('Real Part');
ylabel('Imaginary Part');
grid on;

% Magnitude and Phase Response
[H, w] = freqz(b, a, 512);

% Magnitude Response
figure;
plot(w/pi, abs(H));
title('Magnitude Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('|H(e^{j\omega})|');
grid on;

% Phase Response
figure;
plot(w/pi, angle(H));
title('Phase Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (radians)');
grid on;

% Generate Maximum Phase filter
z_max = 1 ./ conj(z);

% Get new transfer function
[b_max, a_max] = zp2tf(z_max, [], k);

disp('Numerator coefficients (Maximum Phase Filter):');
disp(b_max);
