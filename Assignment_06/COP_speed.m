function [speed] = COP_speed(cop_x,cop_y,sf)
%%COP_speed - calculate the speed at each moment
%Input: 
% cop_x: x coordinates [m]. size = [length,1].
% cop_y: y coordinates [m]. size = [length,1].
% sf: sampling frequency [1/s]
%Output:
% speed: the speed of the COP at each moment [m/s]. size = [length,1].

%% Implementation
t = linspace(0,length(cop_x)/sf,length(cop_x));
t = t';
fittype = 'linearinterp';
f_x = fit(t,cop_x,fittype);
f_y = fit(t,cop_y,fittype);
speed_x = differentiate(f_x,t);
speed_y = differentiate(f_y,t);
speed = sqrt(speed_x.^2 + speed_y.^2);

end