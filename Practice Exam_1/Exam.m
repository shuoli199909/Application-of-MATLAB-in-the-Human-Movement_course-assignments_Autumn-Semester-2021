clear all;close all

% A person is standing on the slackline for a duration of 10 seconds.
% The leg she stands on is equipped with 7 markers: three on the upper leg, one on the knee, and three on the lower leg. 
% The 3D position of these markers is sampled at 100Hz
% Your eventual goal is to calculate, save and plot her knee angle over time for this slackline trial.
% You will reach this goal by solving the problems below.

%% Problem 1.
% Read the unfiltered data from the textfile 'unfiltered_data.txt' Name the resulting matrix 'data_unfiltered'.

info = ...
    fprintf(['The textfile ''unfiltered_data.txt'' contains 3D data from 7 leg markers\n',...
    'of an adult standing on a slackline for 10 seconds.\n',...
    '\n',...
    'The file contains data of:\n',...
    '\n',...
    '1. a marker triangle on the Upper Leg (UL)\n',...
    '2. a single knee marker\n',...
    '3. a marker triangle on the Lower Leg (LL)\n',...
    '\n',...
    'Each marker consists of x, y, and z data.\n',...
    '\n',...
    'The 21 columns of ''unfiltered_data.txt'' thus contain the following data:\n',...
    '\n',...
    'UL1_xyz   UL2_xyz   UL3_xyz   KNEE_xyz    LL1_xyz     LL2_xyz     LL3_xyz\n',...
    '1-3       4-6       7-9       10-12       13-15       16-18       19-21\n',...
    '\n',...
    'Happy analysing!']);


%% Problem 2
% There might be some gaps in the data, during which a marker was invisible. 
% The gaps will be indicated by NaNs in the data and will not be longer than 30 samples.
% Fill those gaps (interpolate missing data) using the function 'fillgap.m', where you set the maximum gap size to 30.
% Name the resulting matrix 'data_unfiltered_filled'.
% Make sure that there are no NaN's left in the data after filling the gaps.


%% Problem 3
% When there are no gaps left in the data, filter the data with a second order lowpass filter with cutoff frequency of 6 Hz
% Name the resulting matrix 'data_filtered'.


%% Problem 4
% Now that we have the filtered data, we will first determine the center of mass of the two marker triangles
% (i.e. the mean position of the three markers of each triangle) to effectively reduce each of them to one marker. 

% Determine the mean position of the three markers on the upper leg (i.e. create a single upper leg variable named UL_MARKER).
% Determine the mean position of the three markers on the lower leg (i.e. create a single lower leg variable named LL_MARKER).
% Create a variable for the knee marker as well, named KNEE_MARKER.

% You should now have the 1000x3 matrices UL_MARKER, LL_MARKER, and KNEE_MARKER in your workspace.


%% Problem 5
% Now that we have markers for lower leg, upper leg and knee, we can create vectors representing the upper and lower legs.
% Create matrices (i.e. time series) of the upper and lower leg vectors (named UL_VECTOR and LL_VECTOR, respectively). 
% The upper leg vector is defined as UL_VECTOR = UL_MARKER minus KNEE_MARKER
% The lower leg vector is defined as LL_VECTOR = LL_MARKER minus KNEE_MARKER

% note that UL_VECTOR and LL_VECTOR should both be 1000x3 matrices.


%% Problem 6
% Now that we have the upper and lower leg vectors, we can determine the knee angle over time. 
% This is simply the angle between these two vectors.
% Write the function 'angle3d.m', which calculates the angle between two 3D vectors.
% The input to the function will be two 3D vectors.
% The output of the function will be the angle (in degrees) between them.

% HINT: The angle between two 3D vectors can be calculated as follows:
% 1. Take the dot-product of the two vectors (use the matlab function 'dot.m'). Name the resulting variable 'dot_product'.
% 2. Multiply the lengths (norms) of the two vectors (use the matlab function 'norm.m'). Name the resulting variable 'norm_product'.
% 3. Take the inverse cosine of dot_product/norm_product (use the MATLAB function 'acosd.m').

% Using this function, determine the knee angle for each of the 1000 samples.

% name the resulting vector 'KNEE_ANGLE'


%% Problem 7
% Now that we have finished analysing our kinematic data, we can save the fruits of our labor in the structure array 'data'.
% Create the stucture data with the 9 fields:

% sampling_frequency
% data_unfiltered
% data_unfiltered_filled
% data_filtered
% UL_MARKER
% LL_MARKER
% KNEE_MARKER
% UL_VECTOR
% LL_VECTOR
% KNEE_ANGLE


%% Problem 8
% Create a new figure.
% Plot the knee angle over time. Provide a useful title and axis labels for your plot.


%% Problem 9
% Create a new figure.
% Plot the initial position of each marker in a single 3D plot. Use the MATLAB function 'plot3.m'
% Use 'axis equal' to create the same scaling for the x- y- and z-data.
% Create a figure legend in which each marker is identified.



