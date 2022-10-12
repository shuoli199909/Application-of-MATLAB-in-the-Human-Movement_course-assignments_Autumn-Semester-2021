function fernfast
%FERNFAST  Fast MATLAB implementation of the Fractal Fern.
%   Michael Barnsley, Fractals Everywhere, Academic Press, 1993.
%   This version runs forever, or until stop is toggled.
%   See also FERN and FINITEFERN.

shg
clf reset
set(gcf,'units','normalized','outerposition',[0 0 1 1],'color','white',...
    'menubar','none','numbertitle','off','name','Fractal Fern')
x = [.5; .5];
h = plot(x(1),x(2),'.');
darkgreen = [0 2/3 0];
set(h,'markersize',1,'color',darkgreen);
axis([-3 3 0 10])
axis off
stop = uicontrol('style','toggle','string','stop','background','white','position',[50 50 100 50]);
drawnow
% Coefficients for the Black Spleenwort fern      % Mutant fern variety: The  Thelypteridaceae fern
p  = [ .85  .92  .99  1.00];                      % p  = [ .84  .91  .98  1.00];
A1 = [ .85  .04; -.04  .85];  b1 = [0; 1.6];      % A1 = [ .95  .005; -.005  .93];  b1 = [-.002; 0.5];
A2 = [ .20 -.26;  .23  .22];  b2 = [0; 1.6];      % A2 = [ .035 -.2;  .16  .04];  b2 = [-.09; 0.02];
A3 = [-.15  .28;  .26  .24];  b3 = [0; .44];      % A3 = [-.04  .2;  .16  .04];  b3 = [.083; .12];
A4 = [  0    0 ;   0   .16];  b4 = [0; 0];        % A4 = [  0    0 ;   0   .25];  b4 = [0; -.4];

cnt = 1;

%% NEW START
Number_Of_Dots_To_Plot=2000;
% Initialise the variable 'dots'. That is, create a 2-by-1000 matrix with only zeros:
dots = zeros(2,Number_Of_Dots_To_Plot);
% Place the initial point in the first column of 'dots':
dots(:,1) = x;
% Initalise the counter-variable 'k' (for deciding when to plot):
k=2;
% % Initialise the counter-variable 's' (for counting the plots):
% s=1;
%% NEW END

tic
while ~get(stop,'value')
    r = rand;
    if r < p(1)
        dots(:,k) = A1*dots(:,k-1) + b1;
    elseif r < p(2)
        dots(:,k) = A2*dots(:,k-1) + b2;
    elseif r < p(3)
        dots(:,k) = A3*dots(:,k-1) + b3;
    else
        dots(:,k) = A4*dots(:,k-1); 
    end
    
    %% NEW START
    if k==Number_Of_Dots_To_Plot % This part is only executed if k is equal to Number_Of_Dots_To_Plot!
        
        % Give the plot (created on line 12) new x- and y- values (i.e. new points):
        
%         % First, we copy all dots that are currently plotted (in order not to have them erased):
%         h(s) = copyobj(h(1),gca);
%         % Then, we give the copied version (which is not drawn yet) the new dots to be plotted:
%         set(h(s),'xdata',dots(1,:),'ydata',dots(2,:));
%         % Finally, we draw the new points:
%         drawnow
        
        set(h,'xdata',[get(h,'xdata'),dots(1,:)],'ydata',[get(h,'ydata'),dots(2,:)])
        drawnow
        
        % Place the point in the last column of 'dots' in the first column of 'dots':
        dots(:,1) = dots(:,k);
        % Update the counter-variable 'k'
        k=2;
%         % Update the plot-counter-variable 's'
%         s=s+1;
    else % This part is executed if k is NOT equal to Number_Of_Dots_To_Plot!
        
        % Update the counter variable 'k'
        k=k+1;
    
    end
    %% NEW END
    
    cnt = cnt + 1;
end

t = toc;
s = sprintf('%8.0f points in %6.3f seconds',cnt,t);
set(gcf,'name',['Fractal Fern: ',s]);
set(stop,'style','pushbutton','string','close','callback','close(gcf)')
