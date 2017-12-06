function X = normalize(X)
%Normalize the input features.
%Usage:
%Xout = normalize(Xin)
%Xin is the input matrix with each row representing a training example and
%each column representing a feature. Xout is the normalized output with
%zero mean and unit variance.
m = size(X,2);
for i=1:m
    X(:,i) = (X(:,i)-min(X(:,i)))/(max(X(:,i))-min(X(:,i)));
end
X = [ones(size(X,1),1) X];