function accu = testsvm(test_data, test_label, w, b)
% Test linear SVM 
% Input:
%  test_data: M*D matrix, each row as a sample and each column as a
%  feature
%  test_label: M*1 vector, each row as a label
%  w: feature vector 
%  b: bias term
%
% Output:
%  accu: test accuracy (between [0, 1])
%
% CSCI 576 2014 Fall, Homework 3

[N,D] = size(test_data);

rightNo = 0;
for i = 1:N
    y = test_data(i,:) * w + b;
    if y * test_label(i,1) >= 0
        rightNo = rightNo + 1;
    end
end

accu = rightNo / N;

end