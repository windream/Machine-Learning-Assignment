function eigenvecs = pca_fun(X, d)

% Implementation of PCA
% input:
%   X - N*D data matrix, each row as a data sample
%   d - target dimensionality, d <= D
% output:
%   eigenvecs: D*d matrix
%
% usage:
%   eigenvecs = pca_fun(X, d);
%   projection = X*eigenvecs;
%
% CSCI 576 2014 Fall, Homework 5

%norm


[m,n] = size(X);
%U = zeros(n);
%S = zeros(n);
cov = 1/m * X' * X;
[U,S,V] = svd(cov);

eigenvecs = U(:,1:d);




end