clear;close all;clc

%% EXAM 2018 - THE SOUND OF MOVEMENT

% What if we could make our muscles sing?
% In this exam, you'll show me that we can!


%% Warmup - The sound of music
% In our warmup (problems 1-5), we will treat music as if it were muscle
% and thereby gain more insight into the filtering process.

%% Problem 1
% Read the file 'doremi.wav' using the built-in MATLAB function 'audioread'.
% make sure the first output of 'audioread' is named 'song'
% and the second output of 'audioread' is named 'fsong'.
% Put your headphones on and ...
% ... make your computer play the song using the built-in MATLAB function 'sound'.
% To stop playing, simply type 'clear sound' in your command window.





% If you couldn't do Problem 1, uncomment the following line before trying Problem 2:
% load Problem1

% As you can probably see, 'song' is an N-by-2 matrix, which represents
% stereo audio data sampled at the frequency given by 'fsong'.

% We will define bass (treble) frequencies as frequencies below (above) 500Hz.
% Below, we will split our audio file into its bass and treble components
% (e.g. to send to a subwoofer and tweeters, respectively).

%% Problem 2
% Apply a recursive 3rd order low-pass Butterworth filter with cutoff frequency 500Hz
% to both columns of the variable 'song'. Call the resulting variable 'songbass'
% and play it using the built-in MATLAB function 'sound'.
% To stop playing, simply type 'clear sound' in your command window.





% Hint: Use the functions 'butter' and 'filtfilt' as we did during our EMG analyses.
%	  Use a for-loop to cycle through both columns of 'song'.

% If you couldn't do Problem 2, uncomment the following line before trying Problem 3:
% load Problem2

%% Problem 3
% Apply a recursive 3rd order high-pass Butterworth filter with cutoff frequency 250Hz
% to both columns of the variable 'song'. Call the resulting variable 'songtreble'
% and play it using the built-in MATLAB function 'sound'.
% To stop playing, simply type 'clear sound' in your command window.





% If you couldn't do Problem 3, uncomment the following line before trying Problem 4:
% load Problem3

%% Problem 4
% Sum the 'songbass' and 'songtreble' components. Call the resulting variable 'songbasstreble'
% and play it using the built-in MATLAB function 'sound'.
% To stop playing, simply type 'clear sound' in your command window.





%% Problem 5
% Save the variables 'songbass' and 'songtreble' as fields in a structure array named 'examstruct'.





%% Workout - The sound of muscle
% In our workout (problems 6-15), we will treat muscle as if it were music
% and thereby gain more insight into human gait.

%% Problem 6
% Load the file 'walking.mat', which contains EMG data of tibialis anterior and soleus during walking.
% Subsequently, create (1) the vector 'tib', which should contain the tibialis EMG data
% (2) the vector 'sol', which should contain the soleus EMG data, and
% (3) the vector 'time', which should contain the time data, in seconds.





% If you couldn't do Problem 6, uncomment the following line before trying Problem 7:
% load Problem6

%% Problem 7
% Preprocess the 'tib' and 'sol' vectors by:
% (1) determining the offset using the first 0.1 seconds of each vector
%      and removing this offset from both vectors.
% (2) Filtering the data in both vectors using a recursive 3rd order high-pass
%      Butterworth filter with cutoff frequency 20Hz
% (3) Rectifying the EMG in both vectors
% (4) Smoothing the EMG in both vectors using a moving average.
%      The window width should be 0.2 seconds.
% If you use a function to preprocess the EMG data,
% paste the function at the bottom of this script, below the heading: 'FUNCTIONS USED IN SCRIPT'.





% If you couldn't do Problem 7, uncomment the following line before trying Problem 8:
% load Problem7

%% Problem 8
% Normalize the 'tib2' and 'sol2' vectors so that their maximum value is 1.
% Name the normalized variables 'tib3' and 'sol3'.





% If you couldn't do Problem 8, uncomment the following line before trying Problem 9:
% load Problem8

%% Problem 9
% Plot the variables 'tib3' and 'sol3' against the variable 'time'.
% Provide a legend identifying the muscles.





%% Problem 10
% Read the file 'tibsound.wav' using the built-in MATLAB function 'audioread'.
% make sure the first output of 'audioread' is named 'tibsound'
% and the second output of 'audioread' is named 'faudio'.
% Subsequently, read the file 'solsound.wav'. Generate only 1 output and name it 'solsound'.





% If you couldn't do Problem 10, uncomment the following line before trying Problem 11:
% load Problem10

%% Problem 11
% Use the built-in MATLAB functions 'rat' and 'resample' to upsample the 'tib3' an 'sol3' data vectors
% (sampled at 1500Hz) to 44100Hz (the audio sample frequency).
% Name the resulting variables 'tib4' and 'sol4'.

% Hint: 'rat' is used to generate the second and third inputs of 'resample'.





% If you couldn't do Problem 11, uncomment the following line before trying Problem 12:
% load Problem11

%% Problem 12
% Scale each sample of both columns of the variable 'tibsound' using the vector 'tib4'
% as the scaling factors, and name the resulting 2-column variable 'tibsound2'.
% Subsequently, scale each sample of both columns of 'solsound' using the vector 'sol4' 
% as the scaling factors, and name the resulting 2-column variable 'solsound2'.





% If you couldn't do Problem 12, uncomment the following line before trying Problem 13:
% load Problem12

%% Problem 13
% Sum the variables 'tibsound2' and 'solsound2'. Name the resulting variable 'musclesound'
% and play it using the built-in MATLAB function 'sound'.
% To stop playing, simply type 'clear sound' in your command window.





% If you couldn't do Problem 13, uncomment the following line before trying Problem 14:
% load Problem13

%% Problem 14
% Add to the structure array 'examstruct' fields containing the following variables:
% - fEMG
% - faudio
% - tib3
% - sol3
% - musclesound





% If you couldn't do Problem 9, uncomment the following line before trying Problem 15:
% musclefig = openfig('Problem9.fig');

%% Problem 15
% I started programming an animated timeline in the figure of problem 9. Can you complete it?
% Our goal is to make a vertical line that passes through the plotted EMG to accompany the sound.
% You have to replace the three dots ... with sensible code.

timeline = line ... ; % create the timeline.
legend('Tibialis EMG','Soleus EMG','Timeline') % update the legend
shg % show updated figure.
pause(1) % pause for 1 second to show figure at t=0.
sound(musclesound,faudio) % start playing the sound just before the animation starts.
tic % start stopwatch to control animation speed.
for i =  ... % Cycle through the data, drawing a new line every 1/15th of a second.
	
	... % UPDATE PLOT HERE!

	pause(i/fEMG-toc) % Pause for the time that should have elapsed (i/freq) minus time that has already elapsed (toc).
end

%% FUNCTIONS USED IN SCRIPT











