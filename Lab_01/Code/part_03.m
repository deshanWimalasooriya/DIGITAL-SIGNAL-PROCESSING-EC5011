% === PART 3: Convolution and Filtering in LTI Systems ===

% Define input signal x[n] and impulse response h[n]
x = [1 2 3 4];           % Example signal x[n]
h = [1 -1 2];            % Example LTI system's impulse response h[n]

% (1) Output using convolution
y_conv = conv(x, h);     % Convolution output

% (2) Output using filter
y_filter = filter(h, 1, x);  % a = 1 (FIR filter), equivalent to convolution

% (3) Compare conv vs filter (needs zero-padding filter output)
y_filter_padded = [y_filter, zeros(1, length(y_conv) - length(y_filter))];

% (4) Explore initial and final conditions
% We'll start with non-zero initial condition
zi = [5 5];  % Initial condition (length = length(h)-1)
[y_with_ic, zf] = filter(h, 1, x, zi);  % Filter with initial condition

% Re-run the same filter starting from final condition
x2 = [0 0 0 0];  % Next input
[y_final_continuation, ~] = filter(h, 1, x2, zf);  % Output using final state

% (5) Plotting all outputs
n1 = 0:length(x)-1;
n2 = 0:length(y_conv)-1;

figure;

subplot(4,1,1);
stem(n1, x, 'filled');
title('Input Signal x[n]');
xlabel('n'); ylabel('x[n]'); grid on;

subplot(4,1,2);
stem(n2, y_conv, 'filled');
title('Output using conv()');
xlabel('n'); ylabel('y_{conv}[n]'); grid on;

subplot(4,1,3);
stem(n2, y_filter_padded, 'filled');
title('Output using filter()');
xlabel('n'); ylabel('y_{filter}[n]'); grid on;

subplot(4,1,4);
stem(0:length(y_with_ic)-1, y_with_ic, 'filled');
title('Output using filter() with Initial Condition');
xlabel('n'); ylabel('y_{IC}[n]'); grid on;

% (6) Explanation:
% y_conv and y_filter match only if length and zero-padding are considered.
% y_with_ic starts higher due to initial condition.
% zf holds the final state of internal delay elements.

% (7) Manual Convolution (step-by-step)
x_pad = [x, zeros(1, length(h)-1)];
h_pad = [h, zeros(1, length(x)-1)];
y_manual = zeros(1, length(x)+length(h)-1);

figure;
for n = 1:length(y_manual)
    for k = 1:length(x)
        if (n-k+1 > 0 && n-k+1 <= length(h))
            y_manual(n) = y_manual(n) + x(k)*h(n-k+1);
        end
    end
    % Plot intermediate output after each step
    subplot(length(y_manual),1,n);
    stem(0:length(y_manual)-1, y_manual, 'filled');
    title(['Manual Convolution Step ' num2str(n)]);
    ylim([min(y_manual)-1, max(y_manual)+1]);
end
