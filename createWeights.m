function [Win,Wrec] = createWeights(netDim,inputLength,connectivity)
%Generates the input and recurring weights for an ESN network.
%Usage:
%[Win,Wrec] = createWeights(netDim,inputLength,connectivity,specRad)
%Win and Wrec are the input and recurring weights respectively, for the
%given network dimension, input length, connectivity and spectral radius.
intWM0 = sprand(netDim, netDim, connectivity);
opts.disp = 0;
SR = abs(eigs(intWM0,1, 'lm', opts));
intWM0 = intWM0/SR;

Win = (2.0 * rand(netDim, inputLength)- 1.0);
Wrec = intWM0;