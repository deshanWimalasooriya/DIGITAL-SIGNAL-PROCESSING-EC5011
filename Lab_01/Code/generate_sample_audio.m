% === Create synthetic "audio" with 3 tone segments ===

fs = 8000;             % Sampling frequency
duration = 0.5;        % Duration per segment (0.5 seconds)
t = 0:1/fs:duration-1/fs;

% Simulated words as different tones
word1 = 0.8*sin(2*pi*440*t);   % "Word 1" - A4 tone
word2 = 0.8*sin(2*pi*660*t);   % "Word 2" - E5 tone
word3 = 0.8*sin(2*pi*880*t);   % "Word 3" - A5 tone

% Silence between words
silence = zeros(1, fs*0.2);  % 200 ms silence

% Combine into full signal
x = [word1 silence word2 silence word3];

% Write to audio.wav
audiowrite('audio.wav', x, fs);

% Playback
sound(x, fs);
disp('Generated and played audio.wav');
