%% Assignment 4 - Make your own EMG Processing Functions

% This week's assignment requires you to write three functions.

% When writing a function, the first questions should always be:
% What is the input? What is the output? What are the calculations in between?. 
% All three functions you will write should, of course, work for the tapping data we analysed above.
% Do not forget to comment every programming step in your function.

% Write the functions as separate m-files to test them, but, once you're ready to submit,
% copy the code in each of your three functions into this m-file 
% and upload ONLY this m-file (with your last and first name) to Moodle.

% Good luck!

% 1. Write the function 'preprocess_emg.m'. This function should perform the following standard preprocessing steps:
%    - removing offset
%    - filtering
%    - rectifying
%    - smoothing
%    Design the function such, that it can be used in other EMG experiments as well.

function [data_offset,data_filt,data_abs,data_smooth] = preprocess_emg(...
    data,time4offset,sf,...
    filt_mode,filt_pass,filt_order,...
    time4smoothing,smooth_mode)
%%   preprocess_emg-summary
%    data -- Input EMG data
%    time4offset -- [second] the length of time used for removing offset
%    sf -- Sampling frequency
%    filt_mode -- 'high' or 'low'
%    filt_pass -- Cut off frequency
%    filt_order -- Filter order
%    time4smoothing -- [second] the length of time used for smoothing
%    smooth_mode --    Available methods are:
%                      'moving'   - Moving average (default)
%                      'lowess'   - Lowess (linear fit)
%                      'loess'    - Loess (quadratic fit)
%                      'sgolay'   - Savitzky-Golay
%                      'rlowess'  - Robust Lowess (linear fit)
%                      'rloess'   - Robust Loess (quadratic fit)

%%   Detailed explanation goes here
%    1 - removing offset

% Determine offset
frame4offset = round(time4offset*sf);
% Remove offset from all data
data_offset = data - mean(data(1:frame4offset));

%    2 - filtering

% Normalised filter parameter
EMG_Wn = filt_pass*2/sf;
% Determine filter coefficients
[EMG_B,EMG_A] = butter(filt_order,EMG_Wn,filt_mode);
% Apply filter to EMG data
data_filt = filtfilt(EMG_B,EMG_A,data_offset);

%    3 - rectifying

% Turn all negative data points into positive data points
data_abs = abs(data_filt);

%    4 - smoothing

% Window width in frames
frame4smoothing = round(time4smoothing*sf);
% Apply smoothing to EMG data
data_smooth = smooth(data_abs,frame4smoothing,smooth_mode);

end

% 2. Write the function 'mvc_normalise_emg.m'. 
%    This function should perform amplitude normalisation based on MVC measurements.

function [data_normed] = mvc_normalise_emg(data)
%%   mvc_normalise_emg-summary
%    data -- Input EMG data. This data should be smoothed and then inserted
%    into this function.

%%   Detailed explanation goes here

% Find the maximum of the input data
data_max = max(data);
% Perform amplitude normalisation
data_normed = 100*data/data_max;

end

% 3. Write the function 'time_normalise.m'.
%    This function should perform time normalisation on any data vector that you give it as input. 

function [data_timenormed] = time_normalise(data,norm_length,ftype)
%%   time_normalise-summary
%    data -- Input EMG data. [length*1]
%    norm_length -- The length of data after normalizing
%    ftype -- Choices for LIBNAME include:
%             LIBNAME           DESCRIPTION
%             'poly1'           Linear polynomial curve
%             'poly11'          Linear polynomial surface
%             'poly2'           Quadratic polynomial curve
%             'linearinterp'    Piecewise linear interpolation
%             'cubicinterp'     Piecewise cubic interpolation
%             'smoothingspline' Smoothing spline (curve)
%             'lowess'          Local linear regression (surface)

%%   Detailed explanation goes here

% Define the fitting type
ftype = fittype(ftype);
% Create step coordinates
steps = linspace(0,norm_length,length(data));
% Create normed coordinates
time_normed = 0:norm_length;
% Apply the fitting
curve_fitting = fit(steps',data,ftype);
% Use curve_fitting to estimate new data
data_timenormed = feval(curve_fitting,time_normed');

end