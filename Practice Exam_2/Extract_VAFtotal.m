% VAF_total Extraction Natalie Müller
%
% Rolf van de Langenberg - 20140424
%
% This script extracts VAFtotal data from all trials. It should be run
% after running Analysis_Natalie.m, on the mat-files that it produced.
%
% Start with a clean sheet
clear all; close all; clc

% Let user open the data directory...
datafolder = uigetdir([],'SELECT DATA DIRECTORY');

% Make the data directory the current directory
cd(datafolder)

% Load dual data
dualfiles2load = dir('synergies_dual*.mat');

% Extract VAFtotal for all dual and norm is:

for i = 1:length(dualfiles2load)
    
    load(dualfiles2load(i).name)
    
    VAF_total_dual(i,1) = str2num(dualfiles2load(i).name(15:18));
%    VAF_total_dual(i,2) = S.syn2.VAFtotal;
    VAF_total_dual(i,2) = S.syn3.VAFtotal;
    
end


% Load norm data
normfiles2load = dir('synergies_norm*.mat');

for i = 1:length(normfiles2load)
    
    load(normfiles2load(i).name)
    
    VAF_total_norm(i,1) = str2num(normfiles2load(i).name(15:18));
%    VAF_total_norm(i,2) = S.syn2.VAFtotal;
    VAF_total_norm(i,2) = S.syn3.VAFtotal;
    
end


