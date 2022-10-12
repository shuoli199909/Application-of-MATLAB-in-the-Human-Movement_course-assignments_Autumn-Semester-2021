clear; close all; clc;
% ... and change into the data directory using cd:
%% Open the data file
[fname,pname] = uigetfile('*.txt');
cd(pname);
num_head = 5;
delimiter = '\t';
textfile_to_scan = fopen(fname);
structure_data = textscan(textfile_to_scan,'%f %f %f %f %f %*s',"headerlines",num_head,"delimiter",delimiter);
fclose(textfile_to_scan);

textfile_to_scan = fopen(fname);
structure_freq = textscan(textfile_to_scan,'%*s %f',1,"headerlines",2,"delimiter",delimiter);
%% Preprocess EMG data
data = structure_data{4};sf = structure_freq{1};time4offset = 0.1;
filt_mode = 'low'; filt_pass = 6; filt_order = 4;
time4smoothing = 0.05; smooth_mode = 'moving';
[data_offset,data_filt,data_abs,data_smooth] = preprocess_emg(...
    data,time4offset,sf,...
    filt_mode,filt_pass,filt_order,...
    time4smoothing,smooth_mode);
figure(1);
subplot(4,1,1); plot(data_offset);
subplot(4,1,2); plot(data_filt);
subplot(4,1,3); plot(data_abs);
subplot(4,1,4); plot(data_smooth);
%% MVC normalization
[fname,pname] = uigetfile('*.txt');
cd(pname);
num_head = 5;
delimiter = '\t';
textfile_to_scan = fopen(fname);
structure_data = textscan(textfile_to_scan,'%f %f %f %f %f %*s',"headerlines",num_head,"delimiter",delimiter);
fclose(textfile_to_scan);

textfile_to_scan = fopen(fname);
structure_freq = textscan(textfile_to_scan,'%*s %f',1,"headerlines",2,"delimiter",delimiter);



%%
