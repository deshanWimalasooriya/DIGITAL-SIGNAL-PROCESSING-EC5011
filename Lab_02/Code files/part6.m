% WIMALASOORIYA G.H.N.P.D.
% 2022E039

function X = myFFT(x)
    % Get the length of input signal
    N = length(x);
    
    % Base case: if only one sample, return the sample itself
    if N == 1
        X = x;
        return;
    end
    
    % Separate the samples into even and odd
    even_samples = x(1:2:end);    % Samples at even indices
    odd_samples = x(2:2:end);     % Samples at odd indices
    
    % Recursive calls to compute FFT for even and odd parts
    X_even = myFFT(even_samples);  % FFT for even part
    X_odd = myFFT(odd_samples);   % FFT for odd part
    
    % Twiddle factor calculation (e^(-j2πkn/N))
    W = exp(-2*pi*1i*(0:N/2-1)/N);  % W_N^k for each frequency bin
    
    % Combine the even and odd parts
    X = [X_even + W .* X_odd, X_even - W .* X_odd];
end

% Sample signal
x = [1, 2, 3, 4, 5, 6, 7, 8];

% Call the custom FFT function
X = myFFT(x);

% Display the FFT result
disp('FFT of the signal:');
disp(X);


% Compare with MATLAB's built-in FFT
X_builtin = fft(x);

% Display the comparison
disp('FFT (manual) vs FFT (built-in):');
disp([X.'; X_builtin.']);
