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


[song,fsong] =  audioread('doremi.wav');
sound(song,fsong)
commandwindow
clc;disp('I''m now playing our song.')
pause
clear sound

save('Problem1.mat','song','fsong')

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


cutoff = 500;
cutoff_norm = cutoff*2/fsong;
[b,a] = butter(3,cutoff_norm,'low');
songbass = zeros(size(song));
for i = 1:size(song,2)
	songbass(:,i) = filtfilt(b,a,song(:,i));
end
sound(songbass,fsong)
clc;disp('I''m now playing only the bass component of our song.')
pause
clear sound

save('Problem2.mat','songbass')

% Hint: Use the functions 'butter' and 'filtfilt' as we did during our EMG analyses.
%	  Use a for-loop to cycle through both columns of 'song'.

%% Problem 3
% Apply a recursive 3rd order high-pass Butterworth filter with cutoff frequency 500Hz
% to both columns of the variable 'song'. Call the resulting variable 'songtreble'
% and play it using the built-in MATLAB function 'sound'.
% To stop playing, simply type 'clear sound' in your command window.


[b,a] = butter(3,cutoff_norm,'high');
songtreble = zeros(size(song));
for i = 1:size(song,2)
	songtreble(:,i) = filtfilt(b,a,song(:,i));
end
sound(songtreble,fsong)
clc;disp('I''m now playing only the treble component of our song.')
pause
clear sound

save('Problem3.mat','songtreble')

%% Problem 4
% Sum the 'songbass' and 'songtreble' components. Call the resulting variable 'songbasstreble'
% and play it using the built-in MATLAB function 'sound'.
% To stop playing, simply type 'clear sound' in your command window.


songbasstreble = songbass + songtreble;
sound(songbasstreble,fsong)
clc;disp('I''m now playing both the bass and treble components of our song.')
pause
clear sound
clc


%% Problem 5
% Save the variables 'songbass' and 'songtreble' as fields in a structure array named 'examstruct'.


examstruct.songbass = songbass;
examstruct.songtreble = songtreble;


%% Workout - The sound of muscle
% In our workout (problems 6-15), we will treat muscle as if it were music
% and thereby gain more insight into human gait.

%% Problem 6
% Load the file 'walking.mat', which contains EMG data of tibialis anterior and soleus during walking.
% Subsequently, create (1) the vector 'tib', which should contain the tibialis EMG data
% (2) the vector 'sol', which should contain the soleus EMG data, and
% (3) the vector 'time', which should contain the time data, in seconds.


load('walking.mat')
tib = EMG{1}; % muscle 1
sol = EMG{2}; % muscle 2
time = (1:length(tib))/fEMG;

save('Problem6.mat','tib','sol','time','fEMG')

%% Problem 7
% Preprocess the 'tib' and 'sol' vectors by:
% (1) determining the offset using the first 0.1 seconds of each vector
%      and removing this offset from both vectors.
% (2) Filtering the data in both vectors using a recursive 3rd order high-pass
%      Butterworth filter with cutoff frequency 20Hz
% (3) Rectifying the EMG in both vectors
% (4) Smoothing the EMG in both vectors using a moving average.
%      The window width should be 0.2 seconds.

% Name the resulting preprocessed vectors 'tib2' and 'sol2'.

% If you use a function to preprocess the EMG data,
% paste the function at the bottom of this script, below the heading: 'FUNCTIONS USED IN SCRIPT'.


time4offset = 0.1;      % Determine offset in the first 0.1 seconds of the trial.
EMG_filttype = 'high';  % High pass filter for EMG data.
EMG_filthighpass = 20;  % [Hz], cut off frequency.
time4smoothing = 0.2;  % This is the window width in seconds.
params = {fEMG,time4offset,EMG_filttype,EMG_filthighpass,time4smoothing};
[~,~,~,tib2] = preprocess_emg(tib,params);
[~,~,~,sol2] = preprocess_emg(sol,params);

save('Problem7.mat','tib2','sol2')

%% Problem 8
% Normalize the 'tib2' and 'sol2' vectors so that their maximum value is 1.
% Name the normalized variables 'tib3' and 'sol3'.


tib3 = tib2/max(tib2);
sol3 = sol2/max(sol2);

save('Problem8.mat','tib3','sol3')

%% Problem 9
% Plot the variables 'tib3' and 'sol3' against the variable 'time'.
% Provide a legend identifying the muscles.


commandwindow
clc;disp('I will now show you a PLOT of tibialis and soleus activity during walking.')
pause(4)
clc;disp('Here it comes:')
pause(1.5)
musclefigure = figure();
set(gcf,'units','normalized','outerposition',[0 0 1 1]) % maximize figure window.
plot(time,tib3,'r','LineWidth',2);
hold on
plot(time,sol3,'b','LineWidth',2);
legend('Tibialis EMG','Soleus EMG')
title('m tibialis anterior and m soleus activity during walking')
xlabel('Time [s]')
ylabel('Normalized EMG amplitude [au]')
shg
pause(4)
commandwindow
clc;disp('Nice plot, nice plot ...')
pause(2)

savefig(musclefigure,'Problem9.fig')

%% Problem 10
% Read the file 'tibsound.wav' using the built-in MATLAB function 'audioread'.
% make sure the first output of 'audioread' is named 'tibsound'
% and the second output of 'audioread' is named 'faudio'.
% Subsequently, read the file 'solsound.wav'. Generate only 1 output and name it 'solsound'.


[tibsound,faudio] = audioread('tibsound.wav');
solsound = audioread('solsound.wav');

save('Problem10.mat','tibsound','solsound','faudio')

%% Problem 11
% Use the built-in MATLAB functions 'rat' and 'resample' to upsample the 'tib3' an 'sol3' data vectors
% (sampled at 1500Hz) to 44100Hz (the audio sample frequency).
% Name the resulting variables 'tib4' and 'sol4'.

% Hint: 'rat' is used to generate the second and third inputs of 'resample'.


[p,q] = rat(faudio/fEMG);
tib4 = resample(tib3,p,q);
sol4 = resample(sol3,p,q);

save('Problem11.mat','tib4','sol4')

%% Problem 12
% Scale each sample of both columns of the variable 'tibsound' using the vector 'tib4'
% as the scaling factors, and name the resulting 2-column variable 'tibsound2'.
% Subsequently, scale each sample of both columns of 'solsound' using the vector 'sol4' 
% as the scaling factors, and name the resulting 2-column variable 'solsound2'.


tibsound2 = repmat(tib4,1,2).*tibsound;
solsound2 = repmat(sol4,1,2).*solsound;

save('Problem12.mat','tibsound2','solsound2')

%% Problem 13
% Sum the variables 'tibsound2' and 'solsound2'. Name the resulting variable 'musclesound'
% and play it using the built-in MATLAB function 'sound'.
% To stop playing, simply type 'clear sound' in your command window.


musclesound = tibsound2 + solsound2;
commandwindow
sound(musclesound,faudio)
clc;disp('I''m now showing you the SOUND of tibialis and soleus activity during walking!')
pause
clear sound

save('Problem13.mat','musclesound')

%% Problem 14
% Add to the structure array 'examstruct' fields containing the following variables:
% - fEMG
% - faudio
% - tib3
% - sol3
% - musclesound


examstruct.samplingfrequencies.EMG = fEMG;
examstruct.samplingfrequencies.audio = faudio;
examstruct.EMG.tib = tib3;
examstruct.EMG.sol = sol3;
examstruct.musclesound = musclesound;


%% Problem 15
% I started programming an animated timeline in the figure of problem 9. Can you complete it?
% My goal is to make a vertical line that passes through the plotted EMG to accompany the sound.

timeline = line([0 0],[0 1],'color','black','linewidth',2); % create the timeline.
legend('Tibialis EMG','Soleus EMG','Timeline') % update the legend
shg % show updated figure.
pause(1) % pause for 1 second to show figure at t=0.
sound(musclesound,faudio) % start playing the sound just before the animation starts.
tic % start stopwatch to control animation speed.
for i =  1:100:length(tib3) % Cycle through the data, updating the plot every 1/15th of a second.
	
	% UPDATE PLOT HERE!
		timeline.XData = [time(i),time(i)];
	
	pause(i/fEMG-toc) % Pause for the time that should have elapsed (i/freq) minus time that has already elapsed (toc).
end

clc
commandwindow
disp('Was that fun or what?!')
pause(3)
clc

%% FUNCTIONS USED IN SCRIPT

function [do,df,da,ds] = preprocess_emg(data_raw,params)

%  function to process (EMG) data in four steps:
%           1. remove offset
%           2. filter (3rd order recursive Butterworth filter)
%           3. rectify
%           4. smooth (moving average)
%
%  inputs:  data_raw = raw EMG data
%           params = 1x5 cell array with the following preprocessing parameters:
%           1. sf                  % Sampling frequency.
%           2. time4offset         % Determine offset in the first 0.1 seconds of the trial.
%           3. filttype            % 'high' or 'low' depending on data type.
%           4. cutoff              % [Hz], cut off frequency.
%           5. time4smoothing      % This is the window width in seconds.
%
%  outputs: data_offset = data after offset removal
%           data_filtered = data after offset removal and filtering
%           data_abs = data after offset removal, filtering and rectifying
%           data_smooth = data after offset removal, filtering, rectifying and smoothing
%
%  Rolf van de Langenberg, November 2017
%

% Set parameters:
sf = params{1};               % [Hz] sampling frequency.
time4offset = params{2};      % Determine offset in the first 0.1 seconds of the trial.
filttype = params{3};         % 'high' or 'low' depending on data type.
cutoff = params{4};           % [Hz] cut off frequency.
time4smoothing = params{5};   % This is the window width in seconds.

% Remove offset
frames4offset = round(time4offset * sf);
do = data_raw - mean(data_raw(1:frames4offset));

% Filter
[B,A] = butter(3,cutoff*2/sf,filttype);
df = filtfilt(B,A,do);

% Rectify
da = abs(df);

% Smooth
frames4smoothing = round(time4smoothing * sf);
ds = smooth(da,frames4smoothing,'moving');

end










