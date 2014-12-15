function [w,b] = trainsvm(train_data, train_label, C)
% Train linear SVM (primal form)
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  C: tradeoff parameter (on slack variable side)
%
% Output:
%  w: feature vector (column vector)
%  b: bias term
%
% CSCI 576 2014 Fall, Homework 3

[N,D] = size(train_data);
% disp(D)
% disp(N)

%w = ones(D,1);
%eps = ones(N,1);
%b = 1;

A1 = zeros(N,D);
for i = 1:N
    A1(i,:) = train_label(i,1) * train_data(i,:);
end

%z = [w;eps;b];
H = diag([ones(1,D),zeros(1,N+1)]);
f = [zeros(D,1);C*ones(N,1);0];
A = [-A1,-eye(N),-train_label];
bb = -ones(N,1);

% A = [A1,eye(N),train_label];
% bb = ones(N,1);

lb = [-inf(D,1);zeros(N,1);-inf];
% lb = zeros(N+D+1,1);
% ub = [inf[N+D+1,1]];
% opts = optimoptions('quadprog','Algorithm','active-set','Display','off');
z = quadprog(H,f,A,bb,[],[],lb,[]);

w = z(1:D,:);
eps = z(D+1:D+N,:);
b = z(D+N+1,:);

end