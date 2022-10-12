function [v,gaps_filled,gaps_unfilled]=fillgap(u,maxgap)

%% function to interpolate only those gaps in a timeseries that are smaller than some critical value
%  input:  u = column vector with time series
%          maxgap = maximal size of gap to interpolate in samples
%  output: v = interpolated time series
%          gaps_filled = number of gaps filled
%          gaps_unfilled = number of gaps unfilled
%%

% generate variables for size u
[m,n]=size(u); 
% index numbers in 'u' that represent good data
good=find(isfinite(u));
% difference between subsequent entries in 'good'
dind=diff(good);
% identify gaps that can be interpolated
ibound1=find(dind<=(maxgap+1)& dind>1);  
% identify gaps that are too large to interpolate
ibound=find(dind>(maxgap+1));  
% number of gaps filled (output 2)
gaps_filled=length(ibound1);
% number of gaps unfilled (output 3)
gaps_unfilled=length(ibound);
% boundary between good data and bad data with gaps > maxgap
% i.e. identifying the edge of each cliff of good data, looking into the gaps
bind=good(ibound); 
% generate list of indexes of 'u'
x=1:length(u);
% interpolate all gaps (also the ones that were too large)
v=interp1(x(good),u(good),x);
% reshape the output 'v' to be of equal size as the input 'u'
v=reshape(v,m,n);
% finally, mask gaps that were longer than maxgap
for j=1:length(bind),
  j0=bind(j)+1;
  j1=bind(j)+dind(ibound(j))-1;
  jj=j0:j1;
  v(jj)=v(jj)*NaN;
end