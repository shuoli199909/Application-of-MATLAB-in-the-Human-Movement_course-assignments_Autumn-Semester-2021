% 2. Write the function 'mvc_normalise_emg.m'. 
%    This function should perform amplitude normalisation based on MVC measurements.

function [data_normed] = mvc_normalise_emg(data)
%%   mvc_normalise_emg-summary
%    data -- Input EMG data. This data should be smoothed and then inserted
%    into this function.

%%   Detailed explanation goes here
data_max = max(data);
data_normed = 100*data/data_max;

end