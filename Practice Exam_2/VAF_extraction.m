% Analysis Natalie Müller: Variance Accounted For in each Condition
%
% Rolf van de Langenberg - 20140206
%
%
% Start with a clean sheet
clear all; close all; clc

%% Load data


% Let user open the data directory (i.e. the directory with the
% 'synergies_*.mat' files):
datafolder = uigetdir([],'SELECT DATA DIRECTORY');

% Make the data directory the current directory
cd(datafolder)

% Load dual task data
files2load = dir('synergies_dual*.mat');

for trial = 1:length(files2load)
    load(files2load(trial).name)
    VAFtotal_syn2(trial,1) = str2num(S.name(end-7:end-4));
    VAFtotal_syn2(trial,2) = S.syn2.VAFtotal;
    
end

% Load normal walk data
files2load = dir('synergies_norm*.mat');

for trial = 1:length(files2load)
    load(files2load(trial).name)
    VAFtotal_syn2(trial,3) = str2num(S.name(end-7:end-4));
    VAFtotal_syn2(trial,4) = S.syn2.VAFtotal;
end
