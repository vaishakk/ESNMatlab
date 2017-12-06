clc
clearvars
close all
%%%%%%%%%%%%%%%%%%%Setting up network parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%
netDim = 1000;
connectivity = 0.5;
specRad = 0.7;
etain = 0.7;
lamda = 1;
epsilon = 110;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%Load and prepare Data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load ex3data1.mat
% numClasses = 10;
% N = length(y);
% indx = randperm(N);
% X = X(indx,:); y = y(indx,:);
% save DataMulti.mat 'X' 'y' 'N' 'numClasses'
load DataMulti.mat
Y = zeros(length(y),numClasses);
for i=1:numClasses
    Y(y==i,i) = 1;
end

N = round(0.7*N);
Xt = X(1:N,:); Yt = Y(1:N,:);%Segragate input and output
% X = normalize(X);%Normalize input
inputLength = size(Xt,2);%Number of features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%Calculate network weights%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Win,Wrec] = createWeights(netDim,inputLength,connectivity);
save W.mat 'Win' 'Wrec'
% load W.mat
Win = etain*Win;
Wrec = specRad*Wrec;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%Training the network%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R = runRCNet(Xt,Win,Wrec,lamda);%Run the network
Wout = calcOutputWeights(R,Yt,epsilon);% Calculate output weights
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%Testing the network%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = X(N+1:end,:); Y = y(N+1:end,:);
% X = normalize(X);
R = runRCNet(X,Win,Wrec,lamda);
yo = R*Wout;
for i=1:size(yo,1)
    yl(i) = find(yo(i,:)==max(yo(i,:)));
end
err = 100*sum(yl.'~=Y)/numel(Y);
display(['Testing Efficency = ' num2str(100-err)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%