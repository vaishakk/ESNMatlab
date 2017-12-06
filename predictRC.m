function [label,ml,Rt] = predictRC(X,Rt,Wout,Win,Wrec,lamda)
R = runRCNet(X,Rt,Win,Wrec,lamda,0);
yo = R*Wout;
[ml,label] = max(yo.');
Rt = R(end,:).';