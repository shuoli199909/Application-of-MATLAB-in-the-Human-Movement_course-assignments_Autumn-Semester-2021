function [S]=SynergyDC(synergies,data) %,bins)
% This function can extract any number of synergies from a matrix of column vectors 
% in which each column represents the preprocessed and normalised data of one muscle.
%
% Inputs:
% 1. 'synergies' 
%     a scalar representing the number of synergies that are to be extracted).
% 2. 'data' 
%     a matrix in which each column represents a time-series of EMG data from a single muscle).
%
% Outputs:
% 1. 'S'
%     a structure array containing the following variables:
%     1. VAFtotal - the total variance in original EMG data accounted for by the extracted synergies.
%     2. W - a matrix containing each of the requested muscle synergies (i.e. one column per synergy).
%     3. T - a matrix containing a time series of activation for each synergy (i.e. one column per time series).
%     4. EMGo - the original EMG (i.e. the same as the input 'data').
%     5. EMGr - the reconstructed EMG, using the requested synergies. (EMGr = W*T)

data = data';
%determine which columns contain NaNs and which contain data
nancolumns=[];
datacolumns=[];
for a=1:length(data);
    if isnan(mean(data(:,a)));
        nancolumns=[nancolumns a];
    else
        datacolumns=[datacolumns a];
    end
end

%delete NaN colums from data matrix
data_woNaN=data;
for b=length(nancolumns):-1:1;
    data_woNaN(:,nancolumns(b))=[];
end

%run NNMF analysis
for i=1:size(synergies,2)
    synnum=synergies(i);
    syn=sprintf('syn%d',synnum);
    [W,T,err] = NNMF(data_woNaN,synnum);
    REMG=W*T;
    [~, S.(syn).VAFtotal,~]=funvafDC(data_woNaN,W,T); %,bins); (there was also an extra output: S.(syn).VAFbin)

    %rebuild reconstructed EMG and factor timing variables to include NaNs
    tempREMG=zeros(size(data,1),length(data_woNaN));
    tempT=zeros(synnum,length(data_woNaN));
    for b=1:length(datacolumns);
        tempREMG(:,datacolumns(b))=REMG(:,b);
        tempT(:,datacolumns(b))=T(:,b);
    end

    for a=1:size(tempT,1);
        for b=1:length(tempT)/101;
            tempTmatrix(b,:)=tempT(a,b*101-100:b*101);
        end
        tempTrow(a,:)=mean(tempTmatrix);
    end


    for c=1:length(nancolumns);
        tempREMG(:,nancolumns(c))=NaN;
        tempT(:,nancolumns(c))=NaN;
    end

    S.(syn).W=W;
    S.(syn).T=tempT;
    S.(syn).EMGr=tempREMG;
    S.(syn).EMGo=data;
end
optional_pause=NaN; %place pause here if you want to view all variables

