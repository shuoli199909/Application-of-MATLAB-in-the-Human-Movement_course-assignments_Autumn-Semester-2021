%% Assignment 6 - Analysing Kinetic Data


% In this assigment, you will further analyse the data from 'Kinetic_Data_Exercise.m'
% Hence, the data set again consists of two mat-files, which contain the raw data (Forces and Moments) of one child in both conditions (EO and EC).
% The forces are saved in the first three columns; the moments in columns 4-6 (see the cell array 'channelNames').

clear; close all; clc;

% Possible solutions to Kinetic_Data_Exercise are repeated below, after which two additional problems(5&6) will be given.

% 1. Load one of the data files (EO/EC) and smooth the force and moment data using a "moving average" with a window width of 100ms.

% Go into the right directory and load
[pname] = uigetdir();
addpath(pname);
load Force_EC.mat;
% Calculate the window width in number of frames
timespan2smooth = 0.1; % [s]
framespan2smooth = round(timespan2smooth * samplingRate);
% Glätten
Data_smooth = NaN(size(Data)); % Initialise
for i=1:size(Data,2)
    Data_smooth(:,i) = smooth(Data(:,i),framespan2smooth,'moving');
end

% 2. From the smoothed data, calculate the x- and y- positions of the COP for each sample using the following equations:
%    x = -(My + Fx*dz)/Fz
%    y =  (Mx - Fy*dz)/Fz
%    where dz (the thickness of the force plate) = -0.055822 m.

% Define parameters
dz = -0.055822; % [m]
% Calculate COP x-coordinates
cop_x = -(Data_smooth(:,5) + Data_smooth(:,1)*dz)./Data_smooth(:,3);
% Calculate COP y-coordinates
cop_y = (Data_smooth(:,4) - Data_smooth(:,2)*dz)./Data_smooth(:,3);


% 3. Plot the x-coordinates of COP against the y-coordinates of COP to obtain a trace of the COP movement during the 30s trial.
%    Don't forget to provide a title, axis labels and a legend for your figure.
%    Also, don't forget to use 'axis equal' so that x- and y-coordinates are scaled equally.
%    Finally, a maximised figure would be nice, of course.

% It's nicer if the plots are in mm (because of the scale) and if their mean lies at the origin of our coordinate system.
% This is easy to do by subtracting the mean of all samples from each sample (i.e. offset removal) and multiply by 1000:
cop_x_mm_zeromean = 1000*(cop_x-mean(cop_x,'all'));
cop_y_mm_zeromean = 1000*(cop_y-mean(cop_y,'all'));

% Then we are ready to plot:
cop_fig = figure();
plot(cop_x_mm_zeromean,cop_y_mm_zeromean,'k-')
title('COP pathway with 95% confidence ellipse','fontsize',14);
xlabel('x [mm]');
ylabel('y [mm]');
grid on; hold on; axis equal;
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure

% This is how we save the figure 'cop_fig' under the name 'cop_figure' and as type 'fig':
saveas(cop_fig,'cop_figure','fig');

% Now we wish to quantify postural stability by means of the area of the smallest ellipse that contains 95% of all data points.
% Put differently, we wish to calculate the area of the 95% confidence ellipse.


% 4. Calculate the area of the 95% confidence ellipse using 'confellipse2.m', which you can download from moodle.
%    You will again need the equations in lines 20 and 21 of this script file.
%    Plot the 95% confidence ellipse in the figure of question 3.

% Given that we chose hold the previous figure (line 60), confellipse2 will plot the 95% confidence ellipse in the same figure as the COP pathway. Nice!
[~,~,area95] = confellipse2([cop_x_mm_zeromean cop_y_mm_zeromean],0.95);
% Now that both the COP pathway and the confidence ellipse are plotted, we can give the plot a legend.
legend('Centre of pressure pathway','95% confidence ellipse');



% 5. Write a function (COP_speed) that calculates the speed of the COP at each moment in time.
% The inputs should be cop_x, cop_y and, of course, the sample frequency.
% The output should be a vector that is equally long as the position vectors cop_x and cop_y.
% With speed, I simply mean how fast the COP is moving. Speed is a number. Velocity, on the other hand, is speed with direction: a vector.

% Hint 1: The MATLAB function 'differentiate.m' differentiates a fitted signal. Remember how to fit a signal? Use the function 'fit.m'. Good luck!
% Hint 2: x- and y-coordinates should be fitted and differentiated separately.
cop_speed = COP_speed(cop_x,cop_y,samplingRate);


% 6. Write a function that calculates the path length of the COP.
% The inputs to the function should simply be cop_x and cop_y.
% The output of the function should be the path length (in meters).

% Hint: The path between two subsequent samples can be approximated by a line, the length of which can be calculated 
% using Pythagoras' theorem a^2 + b^2 = c^2. 
cop_pathlength = COP_path(cop_x,cop_y);













