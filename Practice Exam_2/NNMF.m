function [W,H,err]=NNMF(V,r,opt)
% NNMF: Given a nonnegative matrix V, NNMF finds nonnegative matrix W 
%       and nonnegative coefficient matrix H such that V~WH. 
%       The algorithm solves the problem of minimizing (V-WH)^2 by varying W and H
%       Multiplicative update rules developed by Lee and Seung were used to solve 
%       optimization problem. (see reference below) 
%          D. D. Lee and H. S. Seung. Algorithms for non-negative matrix
%          factorization. Adv. Neural Info. Proc. Syst. 13, 556-562 (2001)
%
% Input: 
%
% V Matrix of dimensions n x m  Nonnegative matrix to be factorized   
% r Integer                     Number of basis vectors to be used for factorization
%                               usually r is chosen to be smaller than n or m so that 
%                               W and H are smaller than original matrix V
% 
% Output:
%
% W    Matrix of dimensions n x r  Nonnegative matrix containing basis vectors
% H    Matrix of dimensions r x m  Nonnegative matrix containing coefficients
% err  Integer                     Least square error (V-WH)^2 after optimization convergence  
% 


if nargin < 3
    % Initial conditions.
    [n,m]=size(V);
    H=rand(r,m);
    W=rand(n,r);
    err=sum(sum((V-W*H).^2));

    MAX_IT=10000;
    % Error goal - the "err" quantity, as defined, is the squared error.  If we
    % want a 1% mse, then, we want .01*prod(size(V))=.01*n*m.
    ERR_GOAL=.001*(n*m);

    % Update...  For normed data, the max err is n x m
    err_save=[];

    V = V.*(V>0); % Any potential negative entrie in data matrix will be set to zero
    while err>ERR_GOAL

        H_fac=W'*V;

        H_fac=H_fac./(W'*W*H);
        H=H.*H_fac;

        W_fac=V*H';
        W_fac=W_fac./(W*H*H');
        
        W=W.*W_fac;

        err=sum(sum((V-W*H).^2));
        
        if err_save>100;
            if err_save(end)-err < .001;
                disp(['Optimization terminated: Convergence achieved at iteration ', num2str(length(err_save)+1), '. Error = ', num2str(err*100/(n*m)), ' %']);
                break;
            end
        end
        
        err_save=[err_save;err];        

        if length(err_save)>MAX_IT
            disp(['Optimization terminated: Exceeds maximum iterations. Error = ', num2str(err*100/(n*m)), ' %']);
            break;
        end
    end
    delete=1;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Synergy vectors normailzation  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    m=max(W);% vector with max activation values
    for i=1:r
        H(i,:)=H(i,:)*m(i);
        W(:,i)=W(:,i)/m(i);
    end
else

%     % Initial conditions.
%     [n,m]=size(V);
%     H=rand(r,m);
% %     W=rand(n,r);
% % need to load cont synergies!
%     load(uigetfile({'*.mat','Synergy Files'},...
%         'Pick a file with Control Synergies'),'Wnew')
%     W = Wnew;
%     err=sum(sum((V-W*H).^2));
% 
%     MAX_IT=10000;
%     % Error goal - the "err" quantity, as defined, is the squared error.  If we
%     % want a 1% mse, then, we want .01*prod(size(V))=.01*n*m.
%     ERR_GOAL=.0001*(n*m);
% 
%     % Update...  For normed data, the max err is n x m
%     err_save=[];
% 
%     V = V.*(V>0); % Any potential negative entrie in data matrix will be set to zero
%     while err>ERR_GOAL
% 
%         H_fac=W'*V;
% 
%         H_fac=H_fac./(W'*W*H);
%         H=H.*H_fac;
% 
% %         W_fac=V*H';
% %         W_fac=W_fac./(W*H*H');
% % 
% %         W=W.*W_fac;
% 
%         err=sum(sum((V-W*H).^2));
%         err_save=[err_save;err];
% 
%         if length(err_save)>MAX_IT
%             break;
%         end
%     end
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Synergy vectors normailzation  %
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
%     m=max(W);% vector with max activation values
%     for i=1:r
%         H(i,:)=H(i,:)*m(i);
%         W(:,i)=W(:,i)/m(i);
%     end
end