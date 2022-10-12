% Please follow the instructions below by typing MATLAB code or MATLAB comments in this m-file.
% Subsequently, save the m-file in the format: 'Assignment_02_Yourlastname_Yourfirstname.m' 
% Finally, upload the assignment on Moodle. Good luck!

% 1. Present your solution to the randomwalk problem.

% 2. Directly below the download link for this m-file, there is a download-link to the function 'fernfast.m',
%    which is an adapted version of the original function 'fern.m'.
%
%    If you run both functions, you can see a clear difference in the speed with which the fern is created. 
%    Can you explain why fernfast creates the fern faster than the original function 'fern.m'?
%    Please refer to the actual MATLAB code of 'fernfast.m'.
%    For your convenience, I have indicated the code that is different from that in 'fern.m'.

%% The solution to the randomwalk problem

clear; close all; clc;
position = [0];
for i = 1:1000
   dice = randi([1,6],1,1);
   position_end = position(end);  
   if dice <= 3
      position = [position, position_end + 1];
   else
      position = [position, position_end - 1];
   end
end
step = linspace(0,1000,1001);
figure(1);
plot(step, position);
xlabel("the girl's steps");
ylabel("position [m]");

%% The answer to the fern function

% The 'fernfast.m' uses a pretty short time to plot a number of dots
% compared with the 'fern.m'. These two functions are similar. The
% difference is that in 'fernfast.m', the code will draw dots on the figure
% only when k==Number_Of_Dots_To_Plot, in other time, the new generated
% dots are stored in the array. But in 'fern.m', the code will draw dots on
% the figure in each loop. In order to verify it, I changed the value of
% the variable "Number_of Dots_To_Plot". When it is lower, the plotting speed
% is slower. When it equals to 2, the speed is similar with the speed in
% "fern.m".
