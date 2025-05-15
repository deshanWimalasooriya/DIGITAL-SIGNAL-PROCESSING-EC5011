% === PART 2: Audio Signal Time and Frequency Analysis ===

% 1. Read audio file
[x, fs] = audioread('jaffna.wav');
x = x(:,1);  % Use only one channel if stereo

% 2. Plot time-domain waveform
t = (0:length(x)-1)/fs;
figure;
subplot(2,1,1);
plot(t*1000, x);
xlabel('Time (ms)');
ylabel('Amplitude');
title('Time-Domain Signal');

% 3. Plot frequency spectrum
X = fft(x);
N = length(X);
f = (0:N-1)*fs/N;

subplot(2,1,2);
plot(f, abs(X));
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude Spectrum');
xlim([0 fs/2]);

% 4. Segment audio into words (manually identified regions)
% You can update these indices after zooming into the plot
word1 = x(9000:15000);     % Example segment for word 1
word2 = x(16000:22000);    % Example segment for word 2
word3 = x(23000:28000);    % Example segment for word 3

% 5. Play the segmented words
disp('Playing Word 1...');
sound(word1, fs);
pause(length(word1)/fs + 0.5);

disp('Playing Word 2...');
sound(word2, fs);
pause(length(word2)/fs + 0.5);

disp('Playing Word 3...');
sound(word3, fs);
pause(length(word3)/fs + 0.5);

% 6. Save the words to new WAV files
audiowrite('word1.wav', word1, fs);
audiowrite('word2.wav', word2, fs);
audiowrite('word3.wav', word3, fs);

disp('Words saved as word1.wav, word2.wav, and word3.wav');
