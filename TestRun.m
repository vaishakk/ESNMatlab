clc
clearvars
close all
%%%%%%%%%%%%%%%%%%%Setting up network parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%
netDim = 1000;
connectivity = 0.1;
specRad = 0.4;
etain = 0.7;
lamda = 1;
epsilon = 0;
numSpeakers = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%Load and prepare Data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = load('ex2data2.txt');%Read data from file
N = size(data,1);
data = data(randperm(N),:);
X = data(1:N, [1, 2]); y = data(1:N, 3);%Segragate input and output
X = normalize(X);%Normalize input
inputLength = size(X,2);%Number of features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%Calculate network weights%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Win,Wrec] = createWeights(netDim,inputLength,connectivity);
% save W.mat 'Win' 'Wrec'
Win = etain*Win;
Wrec = specRad*Wrec;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%Training the network%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Rt = zeros(netDim,1);%Initialize state to all zeros
R = runRCNet(X,Rt,Win,Wrec,lamda,1);%Run the network
Wout = calcOutputWeights(R,y,epsilon);% Calculate output weights
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%Testing the network%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X = data(N+1:end,[1 2]); y = data(N+1:end,3);
% X = normalize(X);
Rt = zeros(netDim,1);%Initialize state to all zeros
R = runRCNet(X,Rt,Win,Wrec,lamda,1);
yo = R*Wout;
yo(yo>0.5) = 1;
yo(yo<0.5) = 0;
err = 100*sum(abs(y - yo))/numel(y);
display(['Error = ' num2str(err) '%'])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%