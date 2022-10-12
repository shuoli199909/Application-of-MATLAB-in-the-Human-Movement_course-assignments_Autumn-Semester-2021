% MATLAB in the Human Movement Sciences
% Exam
%
% Rolf van de Langenberg
%
% Start with a clean sheet:
clear all;close all;clc
%
% A well-known hypothesis in motor control is the so-called muscle synergy hypothesis.
% It states that, when performing a complex motor task (such as walking),
% we do NOT control the many muscles involved in the task individually.
% Rather, we control a relatively small number of 'muscle synergies'.
% In doing so, the number of units to be controlled (a few muscle synergies instead of many muscles)
% decreases and motor control becomes more efficient.
%
% IF motor control works in this way (a big IF!), then we should be able to somehow uncover
% the synergies that are involved in the execution of a complex motor task.
% The task we will look at today is walking.
%
% We will try to uncover the muscle synergies used in walking at preferred and fast speed
% by measuring the activity of 8 muscles (see fig1 below).

% First, we open the directory containing all exam material...
examfolder = uigetdir([],'PLEASE SELECT EXAM DIRECTORY');
cd(examfolder)

load('musclefig.mat');
fig1 = imshow(musclefig);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure

textstring = ...
    sprintf(['Muscles Measured:\n',...
    '\n',...
    '1. tibialis anterior\n',...
    '2. vastus medialis\n',...
    '3. rectus femoris\n',...
    '4. soleus\n',...
    '5. gastrocnemius medialis\n',...
    '6. biceps femoris\n',...
    '7. semitendinosus\n',...
    '8. gluteus medius\n']);

labels = text(size(musclefig,2)+50,250,textstring,'fontsize',16);
text(size(musclefig,2)/5,size(musclefig,1)+30,'press any key to continue','fontsize',16,'color','r','fontweight','bold');shg

pause

% In the data directory you will find two mat-files named walking_fast.mat and walking_preferred.mat.
% These mat-files contain the data of two walking trials: one at preferred speed and one at fast speed.
% This is the data we will work with in the exam.



%% OK then, let the exam begin!



%% Q0: I will first help you along with some familiar commands:

% Start with a clean sheet:
clear all; clc % I will leave the figure open...

% Let user open the data directory...
datafolder = uigetdir([],'SELECT DATA DIRECTORY');
% Make the data directory the current directory
cd(datafolder)

% Read data:
files2load = dir('walking_*.mat');



%% Q1: load the first file in files2load (i.e. it should be the file 'walking_fast.mat'):



%% Q2: The EMG data of the 8 muscles are hidden in a cell array.
%      Please make the matrix EMG (i.e. of data type 'double' not 'cell'), containing 8 columns: one for each muscle.

% -->  If you can't do this, please load 'fast_alternative.mat' instead, so that you can continue with the exam.



%% Q3: Create the vector 'time', which contains the time, in seconds, belonging to each sample.
%      Use the sampling frequency you find in your workspace.

% -->      If you can't do this, please load 'time_fast.mat' instead, so that you can continue with the exam.



%% Q4: Now that we have some EMG data, please demonstrate that you can preprocess them.
%      More specifically, preprocess ONLY the first column of the EMG matrix of Q2 (i.e. vastus medialis)
%      according to the following steps:

%      1. Remove the offset based on the first 0.1 seconds of the trial
%      2. Filter the data (3rd order recursive Butterworth filter)
%      3. Rectify the data
%      4. Smooth the data (window width: 0.1 seconds)
%
%      The smoothed vastus medialis (vm) EMG is all you need. Give this vector the following name: 'EMG_vm_smooth'.



%% Q4: OK, so you can preprocess data for 1 muscle.
%      Can you also make a for-loop, in which you preprocess the data of all 8 muscles in this way?
%      The smoothed EMG of all muscles is all you need. Give this matrix (many rows, 8 columns) the following name: 'EMG_smooth'.

% -->  If you can't do this, please load 'EMG_smooth.mat' instead, so that you can continue with the exam.



% In addition to this preprocessing, synergy extraction also requires that each muscle's EMG is normalised to unit variance.
% This means that all data in a single column need to be divided by the STANDARD DEVIATION of that column.



%% Q5: Please write and save the short function 'unitvariance.m', which has a single column vector as its input,
%      and that single column vector NORMALISED TO UNIT VARIANCE as its output.
%      Subsequently, use this little function to normalise each column of the matrix 'EMG_smooth' in this way. (for-loop!)
%      Give the resulting matrix the following name: 'EMG_unit'.

% -->  If you can't write this minuscule function, normalise all columns of 'EMG_smooth' without using a function.

% -->  If you can't do this either, please load 'EMG_unit.mat' instead, so that you can continue with the exam.



% Now that we have preprocessed and normalised all EMG data for this fast walking trial, we can start thinking of extracting synergies.
% We should, however, only extract synergies from the middle of the trial, where we have steady-state walking.
% The part of the trial in which we have steady-state walking is indicated in the vector 'Markers' (see workspace).
% This vector contains 8 moments in time (in seconds) at which the right foot struck the laboratory floor.
% We will extract 3 synergies from the EMG data of the 7 (steady-state) walking cycles that are enclosed by these 8 markers.



%% Q6: First, please turn all data that fall OUTSIDE these 8 markers into NaN.
%      This is not as easy as it looks, so here's a few hints:
%
%      1. First have MATLAB determine the samples in the vector 'time' that correspond to the times in seconds given in the vector 'Markers'.
%         The question is: Where is the vector 'time' equal to the i-th element in the vector Markers?
%         Use a for-loop to do this one element (of the vector 'Markers') at a time.
%
%      2. Then use these sample numbers to turn the irrelevant data in the matrix 'EMG_smooth' (from Q4) into NaNs.
%
%      Give the resulting 'NaN-ed' matrix the following name: 'EMG_relevant'.

% -->  If you can't do this, please load 'EMG_relevant.mat' instead, so that you can continue with the exam.



% One final thing we need to do before turning to the synergy extraction is that we should downsample the data somewhat.
% Otherwise, the synergy extraction, which requires an optimization procedure, might take ages to complete...



%% Q7: Downsample the EMG matrix and the time vector to 500 Hz using the built-in MATLAB function 'downsample.m'.
%      Give the resulting downsampled EMG matrix the following name: 'EMG_ds'.
%      Give the resulting downsampled time vector the following name: 'time_ds'.

% -->  If you can't do this, please load 'EMG_time_ds.mat' instead, so that you can continue with the exam.



% Finally, we are ready to do our synergy analysis!



%% Q8: Extract 3 synergies by using the function 'SynergyDC.m'.

% -->  If you can't do this, please load 'synergies_fast.mat' instead, so that you can continue with the exam.



%% Q9: And now for some plotting! Please do as many as you wish of the following:
%      1. open a new figure and plot the time vector (x) against the first column of 'EMG_unit'.
%         Make it a black dotted line by providing the following string as the third input for the plot function: '.k'
%      2. Hold the first plot and subsequently plot the downsampled time vector (x) against the first row of 'S.syn3.EMGo' (y).
%         Make it a black solid line by providing the following string as the third input for the plot function: 'k'
%      3. Plot the downsampled time vector (x) against the first row of 'S.syn3.EMGr' (y).
%         Make it a red solid line by providing the following string as the third input for the plot function: 'r'
%      4. Provide appropriate labels for both axes.
%      5. Provide a legend.
%      6. Provide an appropriate title.
%      7. Show gridlines.
%      8. Maximize figure.



% Now that we have extracted muscle synergies in fast walking based on the measurement of 8 muscles,
% we might ask whether the extracted synergies will be different for walking at preferred speed...



%% Q10: Automatically extracting synergies for multiple trials.
%       Perform the analyses in Q1-Q9 for both files contained in the variable 'files2load'.
%       Use a for-loop to do this.
%
%       This is not as easy as it looks, so here's a few hints:
%
%       1. Make sure you clear 'EMG_smooth' and 'EMG_unit' at the end of the for-loop, or else it will become a mess :)
%       2. Make sure the structure array 'S' does not get overwritten. You want to keep the synergies of both trials...





