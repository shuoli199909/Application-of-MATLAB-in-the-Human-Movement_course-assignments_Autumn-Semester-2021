% Please follow the instructions below by typing MATLAB code in this m-file.
% Subsequently, save the m-file in the format: 'Assignment_01_Yourlastname_Yourfirstname.m' 
% Finally, upload the assignment on Moodle. Good luck with (for many of you) your first MATLAB programming steps!

clear all;close all;clc

% If we were to create 10000 samples @ 2000Hz of a sine wave with amplitude 5m and frequency 20Hz,
% how many cycles of this sine wave would be in our sample? 

% --Answer: 
% sample frequency = 2000Hz,number of samples = 10000. 
% so the time of measurement is 5s.
% wave frequency = 20Hz.
% number of cycles = 5*20 = 100

% Create the samples in the form of the variable 'signal'. Make liberal use (cut-paste) of the script 'Example_Problems.m', which you can find in Moodle.
fs = 2000; % sample frequency (Hz)
N = 10000; % number of samples
t = (0:N-1)/fs; % time (seconds)
f_signal = 20; % signal fequency (Hz)
A_signal = 5; % signal amplitude (m)
signal = A_signal*sin(2*pi*f_signal*t);


% Add noise to the signal in the form of another sine wave with amplitude 1m and frequency 400Hz
% (Tip: First create the variable 'noise' containing only the noise-wave. Subsequently, add this noise to the original signal.)
f_noise = 400; % noise frequency (Hz)
A_noise = 1; % noise amplitude (m)
noise = A_noise*sin(2*pi*f_noise*t); % add higher frequency sine wave as noise
signal_with_noise = signal + noise; % original signal + noise
% plot the signal
figure(1);
subplot(1,1,1)
plot(t,signal_with_noise,'b',t,signal,'r','linewidth',0.015);
% since the frequency is too high, I restricted the range of t so that the
% wave shape will be clearer.
xlim([0,0.3]);
title('The Noisy Sine in Time Domain','fontsize',15);
xlabel('time [s]');
ylabel('Amplitude [m]');
legend('Signal with Noise','Signal');
grid;


% Perform a fast fourier transform of the signal and then plot the signal in the frequency domain.
% Can you recognise the frequencies of the signal and of the noise?
figure(2);
fft_signal = abs(fft(signal)/N); % compute the two-sided spectrum
fft_signal = 2*fft_signal(1:N/2+1); % then compute the sigle-sided spectrum
fft_noise = abs(fft(noise)/N);
fft_noise = 2*fft_noise(1:N/2+1);
fft_whole = abs(fft(signal_with_noise)/N);
fft_whole = 2*fft_whole(1:N/2+1);
freq = fs*(0:(N/2))/N; % define the range of frequency

subplot(1,3,1);
plot(freq, fft_signal,'r','linewidth',1); % plot the original signal in frequency domain
xlim([0, 500]);
ylim([0, 5.5]); % restrict the range of X and Y
title('Original Signal','fontsize',15);
xlabel('frequency [Hz]');

subplot(1,3,2);
plot(freq, fft_noise,'g','linewidth',1); % plot the noise in frequency domain
xlim([0, 500]);
ylim([0, 5.5]);
title('Noise','fontsize',15);
xlabel('frequency [Hz]');

subplot(1,3,3);
plot(freq, fft_whole,'b','linewidth',1); % plot the combined signal in frequency domain
xlim([0, 500]);
ylim([0, 5.5]);
title('Original Signal + Noise','fontsize',15);
xlabel('frequency [Hz]');

% After plotting the three signals, it is easy to identify which is the
% original signal and which is the noise. Because the frequency of the
% original signal is lower (20Hz). And the frequency of noise is higher
% (400Hz).