function [label,ml,Rt] = predictRC(X,Rt,Wout,Win,Wrec,lamda)
%[label,ml,Rt] = predictRC(X,Rt,Wout,Win,Wrec,lamda) gives the prediction
%for input X into an RC net defined by the weights Wout, Win and Wrec with
%current state Rt.lamda is the 
R = runRCNet(X,Rt,Win,Wrec,lamda,0);
yo = R*Wout;
[ml,label] = max(yo.');
Rt = R(end,:).';