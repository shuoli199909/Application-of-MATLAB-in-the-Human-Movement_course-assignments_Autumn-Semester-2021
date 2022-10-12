function [VAFmuscle, VAFtotal, VAFpartial]=funvafDC(EMGo,weights,timing) %,bins) (there was also an extra output: VAFbin)
%
%
% This function calculates the Variability Factor of <W>*<C> w.r.t <data>
% in each bin, for each muscle, at each instant in gaitcycle and the overall
% correlation. <syncon> contains the percentage of contribution of each 
% synergy in the reconstruction of <data>.


[nmuscles len]=size(EMGo);
[nsyn length]=size(timing);

%Calculate reconstructed values
EMGr=weights*timing;

%Calculate overall variability VAF (1x1)
ss_error=sum((EMGo - EMGr).^2);
ss_total=sum(EMGo.^2);
VAFtotal=100-ss_error/ss_total;

% %Calculate VAF for each bin
% numofsteps=size(bins,2);
% numofbins=6;
% for a=1:numofbins;
%     binEMGo=[];
%     binEMGr=[];
%     for b=1:numofsteps;
%         tempinds=ceil(bins{b});
%         tempinds(1)=1; %substitute one for zero as first index point
%         tempEMGo=EMGo(:,tempinds(a):tempinds(a+1));
%         tempEMGr=EMGr(:,tempinds(a):tempinds(a+1));
%         binEMGo=[binEMGo tempEMGo];
%         binEMGr=[binEMGr tempEMGr];
%     end
%     bin_ss_error=sum((binEMGo - binEMGr).^2);
%     bin_ss_total=sum(binEMGo.^2);
%     VAFbin(a)=100-bin_ss_error/bin_ss_total*100;
% end

%Calculate VAF for each muscle
numofmuscles=size(EMGo,1);
for a=1:numofmuscles;
    muscleEMGo=EMGo(a,:);
    muscleEMGr=EMGr(a,:);
    muscle_ss_error=sum((muscleEMGo - muscleEMGr).^2);
    muscle_ss_total=sum(muscleEMGo.^2);
    VAFmuscle(a)=100-muscle_ss_error/muscle_ss_total*100;
end
    
   
%Calculate percentage of contribution of each synergy in the reconstruction
%of data. syncon = 1 x nsyn

total_ss_error=sum(sum(EMGr));
for a=1:nsyn;
    EMGr_partial = weights(:,a)*timing(a,:); % Calculate reconstructed data for each synergy
    partial_ss_error = sum(sum(EMGr_partial));
    VAFpartial(a)=partial_ss_error/total_ss_error*100;
end
