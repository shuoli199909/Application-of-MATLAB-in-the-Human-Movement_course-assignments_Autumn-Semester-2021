function [smooth_data] = smooth2(data,span)

%  function [smooth_data] = smooth2(data,span)
%
%  Function that calculates a moving average to smooth data.
% 
%  Syntax: function [smooth_data] = smooth2(data,span)
%
%  Inputs: data = any data vector
%          span = span of the moving window
%  Output: smooth_data = smoothed data with running average method
% 
%  Rolf van de Langenberg, October 2012
 
if nargin < 1
    error('smooth2 needs at least one input argument.');
elseif nargin == 1
    span = 5;
end

% create window variable
sf = floor(.5*span);

% initialise
smooth_data = nan(size(data));

n=length(data);

for i = 1:n
    
    if i <= sf % If there are not enough data points before data(i) to make window of width 'span':        
        smooth_data(i) = mean(data(1:i+(i-1)));
        
    elseif n-i < sf % If there are not enough data points after data(i) to make window of width 'span':
        
        smooth_data(i) = mean(data(i-(n-i):end));
        
    else
        
        smooth_data(i) = mean(data(i-sf:i+sf));
        
    end
    
end