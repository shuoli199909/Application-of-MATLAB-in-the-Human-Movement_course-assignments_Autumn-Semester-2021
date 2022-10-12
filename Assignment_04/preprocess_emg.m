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
frame4offset = round(time4offset*sf);
data_offset = data - mean(data(1:frame4offset));

%    2 - filtering
EMG_Wn = filt_pass*2/sf;
[EMG_B,EMG_A] = butter(filt_order,EMG_Wn,filt_mode);
data_filt = filtfilt(EMG_B,EMG_A,data_offset);

%    3 - rectifying
data_abs = abs(data_filt);

%    4 - smoothing
frame4smoothing = round(time4smoothing*sf);
data_smooth = smooth(data_abs,frame4smoothing,smooth_mode);

end