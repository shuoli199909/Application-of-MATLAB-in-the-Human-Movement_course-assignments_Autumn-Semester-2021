%% Determining maximal knee angles in seven subsequent walking steps

% Please follow the instructions below by typing MATLAB code in this m-file.
% Subsequently, save the m-file in the format:
% 'Assignment_03_Yourlastname_Yourfirstname.m'... 

% ... and upload the m-file on Moodle. Good luck!

clear all;close all;clc

% As you might have noticed, the current assignment comes with a textfile: 'walking_preferred.txt', and a mat-file: 'walking_preferred.mat'. 
% You should only open the mat-file (load('walking_preferred.mat')) if you are unable to load the data from the textfile. 
% Both files contain a time series of the right knee angle during walking at preferred speed.

%% 1. Use 'textscan' to load the data of the textfile into MATLAB and make a plot with 'time [s]' on the x-axis
% and 'knee angle [degrees]' on the y-axis, to get an idea of the data.





clear all; close all; clc

% We are now going to try and determine the maximal knee angle during each swing phase. 
% To do this, we first have do identify each swing phase. How will we go about that?

% We'll do the first steps together; bear with me...
% I will now just load the data from a mat-file (see Moodle), because I don't want to just give you the answer to the first question :)

load('walking_preferred.mat')

% A quick sloppy plot, just to check out the data..
plot(time,angle)

% OK, so there are seven high peaks, which represent the knee angles in subsequent swing phases. 
% The smaller peaks in between are the knee angles in the stance phases.

% We are now going to sneak up on our prey: each individual swing phase. 

% First, we will generate a criterion to distinguish stance and swing phases: 
% If a knee angle is larger than 30 degrees, it must be a swing phase!
swing_threshold = 30;

% We will work with this threshold to catch each and every swingphase. There will be no escape...

% Softly moving closer to our prey, we will identify all data samples that must represent swing phases: 
swing_pointer = int16(angle > swing_threshold);
% angle > swing_threshold by itself generates a vector of the same length as the vector 'angle', filled with only ones and zeros:
% Ones where angle is greater than swing_threshold and zeros where it is smaller than swing_threshold.
% These are so-called logical ones and zeros. With logical ones, you cannot do something like 1*1 or 1+1. Try it if you don't believe me.
% They simply mean 'false' or 'true'...
% The function 'int16' turns these logical ones and zeros into the actual integers 1 and 0. This will be useful for what is to come...

% So now imagine yourself standing at the beginning of the data curve.
% We will now go to the sample where the knee angle is larger than 30 degrees using the function 'find':
pointer_start1 = find(swing_pointer==1,1,'first');
% Then we will replace the zeros in swingpointer before that first one with the number '10'.
swing_pointer(1:pointer_start1-1) = 10;
% Then we will move on to the first zero (and then move one sample back) to mark the end of the first swing phase 
% (after all, the zeros all the way at the beginning are replaced by '10'):
pointer_end1 = find(swing_pointer==0,1,'first')-1;
% and then we will replace the ones between the start and the end of the first swing phase with '20'.
swing_pointer(pointer_start1:pointer_end1) = 20;

% Then we will do EXACTLY THE SAME for the second swing phase, replacing zeros and ones with higher and higher numbers....
% (We can do exactly the same each time (i.e. searching for the first one and then the first zero) 
% because we consistently replace all zeros and ones before the phase of interest.)
pointer_start2 = find(swing_pointer==1,1,'first');
swing_pointer(pointer_end1+1:pointer_start2-1) = 30;
pointer_end2 = find(swing_pointer==0,1,'first')-1;
swing_pointer(pointer_start2:pointer_end2) = 40;

% ...and for the third swing phase
pointer_start3 = find(swing_pointer==1,1,'first');
swing_pointer(pointer_end2+1:pointer_start3-1) = 50;
pointer_end3 = find(swing_pointer==0,1,'first')-1;
swing_pointer(pointer_start3:pointer_end3) = 60;
% ...the fourth
pointer_start4 = find(swing_pointer==1,1,'first');
swing_pointer(pointer_end3+1:pointer_start4-1) = 70;
pointer_end4 = find(swing_pointer==0,1,'first')-1;
swing_pointer(pointer_start4:pointer_end4) = 80;
% ...the fifth
pointer_start5 = find(swing_pointer==1,1,'first');
swing_pointer(pointer_end4+1:pointer_start5-1) = 90;
pointer_end5 = find(swing_pointer==0,1,'first')-1;
swing_pointer(pointer_start5:pointer_end5) = 100;
% ...the sixth
pointer_start6 = find(swing_pointer==1,1,'first');
swing_pointer(pointer_end5+1:pointer_start6-1) = 110;
pointer_end6 = find(swing_pointer==0,1,'first')-1;
swing_pointer(pointer_start6:pointer_end6) = 120;
% ...the last.
pointer_start7 = find(swing_pointer==1,1,'first');
swing_pointer(pointer_end6+1:pointer_start7-1) = 130;
pointer_end7 = find(swing_pointer==0,1,'first')-1;
swing_pointer(pointer_start7:pointer_end7) = 140;

% finally, we have to replace the trailing zeros in our vector 'swing_pointer':
swing_pointer(swing_pointer==0) = 150;
% Do you see that I can simply point to the indexes where swing_pointer is zero by using logical operators between round brackets?!
% Remember this; it can be very handy!

% To make it all a bit nicer, we divide swing_pointer by 10, so it runs from 1:15, instead of 10:10:150
swing_pointer = swing_pointer/10;

% I'll now plot both our swing_pointer and the original data ('angle') in the same plot using the function 'plotyy'.
figure()
[axes_fig1, h_angle, h_pointer] = plotyy(time,angle,time,swing_pointer);
% Finally, I optimise the range of the first (i.e. left) y-axis, using the 'handles' to the axes that were the output of 'plotyy':
set(axes_fig1(1),'YLim',[-5 85])

% So, do you see the logic here? We have a staircase going through our data, and I know exactly which steps in the staircase overlap with
% swing phases (all even steps: 2,4,6,8,10,12,14)! So our staircase really is a pointer. So now I have all individual swing phases in my claws.

% Proof: Determining the maximum value for each swing phase is now a piece of cake:
swing_max_all(1) = max(angle(swing_pointer==2)); % Do you see the logical indexing I used?
% So I define the maximum value in those samples of 'angle' where swing_pointer equals 2...That's the maximum angle in the first swing phase!
swing_max_all(2) = max(angle(swing_pointer==4));
swing_max_all(3) = max(angle(swing_pointer==6));
swing_max_all(4) = max(angle(swing_pointer==8));
swing_max_all(5) = max(angle(swing_pointer==10));
swing_max_all(6) = max(angle(swing_pointer==12));
swing_max_all(7) = max(angle(swing_pointer==14));

% So, that was great: we determined the maximum knee angle in each of the seven swing phases.
% But ... the program is very long and very repetitive. Do you agree?
% This is often a sign that the program can be significantly shortened by using testing blocks: for-loops or while-loops.

%% 2. Replace the repetitive code in lines 117:124 with a for- or while-loop that goes through the steps one-by-one.
      % (After your loop is ready, you should comment (i.e. put %-signs in front of) lines 117:124.)
      % (If your loop works, swing_max_all should still be the same vector of length 7.)






%% 3. replace the repetitive code in lines 56-97 with a while-loop or for-loop that goes through the steps one-by-one.
      % (You should place your code directly below line 97 and then comment (i.e. put %-signs in front of) lines 56:97)
      % (If your loop works, you should be able to plot the staircase and the data using 'plotyy' (see line 109).)

% Hints:
% a possible criterion for the while loop:
% while any(swing_pointer==1) % Use doc any if you need to.
% a possible increment for the for loop:
% for i = 1:7
% Try to manipulate the increment 'i' (e.g. i*20) to generate the values you need within each iteration of the loop. 






%% 4. Save the variable 'swing_max_all' into a mat-file with the name: 'swing_max.mat' (Use doc save if you need to.)








