function Wout = calcOutputWeights(R,D,epsilon)
I = eye(size(R,2));
% I(1,1) = 0;
Wout = pinv((R.'*R)+(epsilon*I))*(R.'*D);