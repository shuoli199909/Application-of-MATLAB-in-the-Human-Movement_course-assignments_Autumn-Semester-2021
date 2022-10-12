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
ftype = fittype(ftype);
steps = linspace(0,norm_length,length(data));
time_normed = 0:norm_length;
curve_fitting = fit(steps',data,ftype);
data_timenormed = feval(curve_fitting,time_normed');

end