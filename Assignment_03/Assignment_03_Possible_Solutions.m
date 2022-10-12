%% Determining maximal knee angles in seven subsequent walking steps

clear all;close all;clc

%% 1. Use 'textscan' to load the data of the textfile into MATLAB and make a plot with 'time [s]' on the x-axis and 'knee angle [degrees]' on the y-axis, to get an idea of the data.

textfile_to_scan = fopen('walking_preferred.txt');
data=textscan(textfile_to_scan,'%f %f %*[^\n]','headerlines',5,'delimiter','\t');
time = data{1};
angle = data{2};

plot(time,angle)

%% 3. replace the repetitive code in lines 56-97 with a while-loop or for-loop that goes through the steps one-by-one.

swing_threshold = 30;
swing_pointer = int16(angle > swing_threshold);
stance_id = 10;
swing_id = 20;
pointer_end = 0;
while any(swing_pointer==1)   % Keep on making 'loopings' until swing_pointer has no ones left...
    pointer_start = find(swing_pointer==1,1,'first');
    swing_pointer(pointer_end+1:pointer_start-1) = stance_id;
    pointer_end = find(swing_pointer==0,1,'first')-1;
    swing_pointer(pointer_start:pointer_end) = swing_id;
    % Increment
    swing_id = swing_id+20;
    stance_id = stance_id+20;
end

% % Option 2
% pointer_end = 0;
% for i=1:7 % Simply go through all swing phases. This only works if you know how many steps are in the data file. If not, use the while-loop!
%     pointer_start = find(swing_pointer==1,1,'first');
%     swing_pointer(pointer_end+1:pointer_start-1) = 20*i-10;
%     pointer_end = find(swing_pointer==0,1,'first')-1;
%     swing_pointer(pointer_start:pointer_end) = 20*i;
% end

swing_pointer(swing_pointer==0) = 150;
swing_pointer = swing_pointer/10;

figure()
[axes_fig1, h_angle, h_pointer] = plotyy(time,angle,time,swing_pointer);
set(axes_fig1(1),'YLim',[-5 85])

%% 2. Replace the repetitive code in lines 117:124 with a for- or while-loop that goes through the steps one-by-one.

lastswing = max(swing_pointer(mod(swing_pointer,2)==0)); % find maximal even element of swing_pointer (i.e. find last swing phase)
% TIP: google: 'find even matrix elements MATLAB'
swing_max_all = inf(lastswing/2,1); % initialize variable swing_max_all as vector of infinite values
for i = 2:2:lastswing % from 2 in steps of 2 through lastswing*2 (i.e. from first swing through last swing)
   swing_max_all(i/2) = max(angle(swing_pointer==i)); % find maximum angle
end

%% 4. Save the variable 'swing_max_all' into a mat-file with the name: 'swing_max.mat' (Use doc save if you need to.)

save('swing_max.mat','swing_max_all')








