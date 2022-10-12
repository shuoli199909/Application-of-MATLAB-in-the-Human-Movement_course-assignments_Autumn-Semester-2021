function [data_offset,data_filtered,data_abs,data_smooth] = preprocess_emg(data_raw,timespan2remOffset,sampling_rate,cutoff,pass,timespan2smooth)

%  function to process (EMG) data in four steps: 
%           1. remove offset
%           2. filter (3rd order recursive Butterworth filter)
%           3. rectify
%           4. smooth (moving average)
%
%  inputs:  data_raw = raw EMG data
%           timespan2remOffset = time at the beginning of the data over which to determine the offset in the EMG data
%           sampling_rate = sampling frequency (Hz) of the emg data
%           cutoff = cutt-off frequency (Hz) of the filter
%           pass = string to determine filter type. Options: 'high' for high-pass, 'low' for low-pass
%           timespan2smooth = 0.05
%
%  outputs: data_offset = data after offset removal
%           data_filtered = data after offset removal and filtering
%           data_abs = data after offset removal, filtering and rectifying
%           data_smooth = data after offset removal, filtering, rectifying and smoothing
%            
%  Rolf van de Langenberg, October 2012
%

% Umrechnen der definierten Zeit in Frames

% Remove offset
framespan2remOffset = round(timespan2remOffset * sampling_rate);
data_offset = data_raw - mean(data_raw(1:framespan2remOffset));

% Filter
[B,A] = butter(3,cutoff*2/sampling_rate,pass); % Filterkoeffizienten
data_filtered = filtfilt(B,A,data_offset);

% Rectify
data_abs = abs(data_filtered);

% Smooth
framespan2smooth = round(timespan2smooth * sampling_rate);
data_smooth = smooth(data_abs,framespan2smooth,'moving');

return
