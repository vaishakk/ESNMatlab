function [X_norm, mu, sigma] = featureNormalize(X,mu,sigma)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1.
X_norm = X;
if nargin==3
    X_norm = X_norm - repmat(mu,[size(X,1) 1]);
    X_norm = X_norm./repmat(sigma,[size(X,1) 1]);
else
    mu = zeros(1, size(X, 2));
    sigma = zeros(1, size(X, 2));
    mu = mean(X,1);
    X_norm = X_norm - repmat(mu,[size(X,1) 1]);
    sigma = std(X_norm);
    X_norm = X_norm./repmat(sigma,[size(X,1) 1]);
end
X_norm = [ones(size(X_norm,1),1) X_norm];