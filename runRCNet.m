function R = runRCNet(X,Rt,Win,Wrec,lamda,display)
%R = runRCNet(X,Rt,Win,Wrec,lamda) runs complete iterations on the RC network 
%defined by the weights Win and Wrec with leakage rate lamda on the input X
%with each row of X representing an example and accumilates all the state 
%in the matrix R. R is a matrix containg all the reservoir states with ith 
%row representing the state corresponding to the input X(i,:).

Nfrm = size(X,1);%Number examples
netDim = size(Win,1);
% Rt = zeros(netDim,1);%Initialize state to all zeros
R = [];
if display
    textprogressbar('Running Network:');
end
for j=1:Nfrm
    Ut = X(j,:).';%jth input
    Rt = (1-lamda)*Rt+lamda*f(Win*Ut + Wrec*Rt);%jth state
    R = [R, Rt];
    if display
        textprogressbar(round(j*100/Nfrm));
%     imshow([zeros(10,5*round(j*100/Nfrm)) ones(10,5*(100-round(j*100/Nfrm)))]);
%      title(['Network progress... ' num2str(round(j*100/Nfrm)) '%'])
%      iptsetpref('ImshowBorder', 'loose');
%      hFig = gcf;
%       % hide the toolbar
%      set(hFig,'menubar','none')
%      % to hide the title
%      set(hFig,'NumberTitle','off');
%      drawnow;
    end
end
if display
    textprogressbar('done');
end
R = R.';