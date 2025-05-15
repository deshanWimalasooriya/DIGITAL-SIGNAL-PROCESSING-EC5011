% WIMALASOORIYA G.H.N.P.D.
% 2022E039

% Define values of 'a'
a_values = [0.9, -0.9];

% Frequency range
[W,~] = freqz(1,[1],512); % just to get W values for plotting

for i = 1:length(a_values)
    a = a_values(i);
    
    % Define H(z) and G(z)
    b_H = 1;          % Numerator of H(z)
    a_H = [1 a];      % Denominator of H(z)
    
    b_G = [1 -a];     % Numerator of G(z)
    a_G = 1;          % Denominator of G(z) (FIR)
    
    % Frequency response for H(z)
    [H,w] = freqz(b_H, a_H, 512);
    
    % Frequency response for G(z)
    [G,~] = freqz(b_G, a_G, 512);
    
    % Plot for H(z)
    figure;
    subplot(2,1,1);
    plot(w/pi, abs(H));
    title(['Magnitude Response of H(z) for a = ' num2str(a)]);
    xlabel('Normalized Frequency (\times\pi rad/sample)');
    ylabel('|H(e^{j\omega})|');
    grid on;
    
    subplot(2,1,2);
    plot(w/pi, angle(H));
    title(['Phase Response of H(z) for a = ' num2str(a)]);
    xlabel('Normalized Frequency (\times\pi rad/sample)');
    ylabel('Phase (radians)');
    grid on;
    
    % Plot for G(z)
    figure;
    subplot(2,1,1);
    plot(w/pi, abs(G));
    title(['Magnitude Response of G(z) for a = ' num2str(a)]);
    xlabel('Normalized Frequency (\times\pi rad/sample)');
    ylabel('|G(e^{j\omega})|');
    grid on;
    
    subplot(2,1,2);
    plot(w/pi, angle(G));
    title(['Phase Response of G(z) for a = ' num2str(a)]);
    xlabel('Normalized Frequency (\times\pi rad/sample)');
    ylabel('Phase (radians)');
    grid on;
end
