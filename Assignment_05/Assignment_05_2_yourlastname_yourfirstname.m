%% Below you'll find a greatly streamlined version of the EMG and GONIO analyses we did in EMG Exercises 2 (only 79 lines left!!).

% Exercise 1:
% Use a for-loop to perform the analyses for all 9 trials in our data folder 
% and save raw and processed data of all trials in a structure array.

% Hint 1: On line 58, I used the function 'dir', which will provide the names of all trials to be analysed.
% Hint 2: Your for-loop should start on line 60, where I already defined a variable 'i' for you.
% Hint 3: On line 62, this 'i' is used to point to one of the 9 trials.

% Exercise 2:
% Save the condition (e.g. '025') and the sampling frequency of each trial in the structure array of Exercise 1.

% Start with a clean sheet:
clear all;close all;clc

%% Read MVC data.
% Tibialis MVC:
[TIB_mvc_fname, TIB_mvc_pname] = uigetfile('*.txt','Select one of the m. Tibialis Anterior MVC trials.');cd(TIB_mvc_pname)
fid = fopen(TIB_mvc_fname);
data = textscan(fid,'%f%f%f%f%*[^\n]','delimiter','\t','headerlines',5);
fclose(fid);
TIB_mvc_EMG = data{:,2}; % Note that the m. Tibialis data is in column 2.

% Soleus MVC:
[SOL_mvc_fname, SOL_mvc_pname] = uigetfile('*.txt','Select one of the m. Soleus MVC trials.');cd(SOL_mvc_pname)
fid = fopen(SOL_mvc_fname);
data = textscan(fid,'%f%f%f%f%*[^\n]','delimiter','\t','headerlines',5);
fclose(fid);
SOL_mvc_EMG = data{:,3}; % Note that the m. Soleus data is in column 3.

%% Read the sampling frequency (once for all trials) from the soleus mvc file.
fid = fopen(SOL_mvc_fname);
sf_cell = textscan(fid,'%*s %f%*[^\n]',1,'delimiter','\t','headerlines',2);
sf = sf_cell{1};
fclose(fid);

%% Define preprocessing parameters:
time4offset = 0.1;        % Determine offset in the first 0.1 seconds of the trial.
EMG_filttype = 'high';    % High pass filter for EMG data.
GONIO_filttype = 'low';   % Low pass filter for gonio data.
EMG_filthighpass = 20;    % [Hz], cut off frequency.
GONIO_filtlowpass = 6;    % [Hz], cut off frequency.
time4smoothing = 0.05;    % This is the window width in seconds.
steps4timenorming = 1000; % This is the number of steps to use for time-normalisation.
delta = 10;               % Minimal vertical distance between adjacent minimal and maximal peaks in gonio data.
sf;                       % Sampling frequency.

params_EMG = {sf,time4offset,EMG_filttype,EMG_filthighpass,time4smoothing};
params_GONIO = {sf,time4offset,GONIO_filttype,GONIO_filtlowpass,time4smoothing};

%% Preprocess MVC EMG data:
[~,~,~,TIB_mvc_preproc] = preprocess_emg(TIB_mvc_EMG,params_EMG);
[~,~,~,SOL_mvc_preproc] = preprocess_emg(SOL_mvc_EMG,params_EMG);

%% Read experimental data:
pname = uigetdir('Select the directory that contains your experimental data.');cd(pname) % this command happens BEFORE the for-loop.
files2read = dir('*tapping*.txt'); % This command happens BEFORE the for-loop and will return a structure array with the names of all tapping trials.

i=1; % Here you should start your for-loop!

fid = fopen(files2read(i).name);
data = textscan(fid,'%f%f%f%f%*[^\n]','delimiter','\t','headerlines',5);
fclose(fid);
Time = data{1,1};TIB = data{1,2};SOL = data{1,3};GONIO = data{1,4};

%% Preprocess experimental data:
[~,~,~,TIB_preproc] = preprocess_emg(TIB,params_EMG);
[~,~,~,SOL_preproc] = preprocess_emg(SOL,params_EMG);
[~,GONIO_preproc] = preprocess_emg(GONIO,params_GONIO);

%% Normalise experimental EMG data to MVC.
[TIB_ampnormed] =  mvc_normalise_emg(TIB_preproc,TIB_mvc_preproc);
[SOL_ampnormed] =  mvc_normalise_emg(SOL_preproc,SOL_mvc_preproc);

%% Detect peaks in experimental goniometer data.
[peaks_max, peaks_min] = peakdet(GONIO_preproc,delta);

%% Extract separate tapping cycles from the tapping trial and time-normalise each of them.
for cycle_id = 1:size(peaks_min,1)-1
    TIB_timenormed(:,cycle_id) = time_normalise(TIB_ampnormed(peaks_min(cycle_id,1):peaks_min(cycle_id+1,1)),steps4timenorming);
    SOL_timenormed(:,cycle_id) = time_normalise(SOL_ampnormed(peaks_min(cycle_id,1):peaks_min(cycle_id+1,1)),steps4timenorming);
    GONIO_timenormed(:,cycle_id) = time_normalise(GONIO_preproc(peaks_min(cycle_id,1):peaks_min(cycle_id+1,1)),steps4timenorming);
end











































