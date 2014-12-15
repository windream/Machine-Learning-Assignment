function [new_accu, train_accu] = knn_classify(train_data, train_label, new_data, new_label, k)
% k-nearest neighbor classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%  k: number of nearest neighbors
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data (using leave-one-out
%  strategy)
%
% CSCI 576 2014 Fall, Homework 1

ClassLabel=unique(train_label);
c=length(ClassLabel);
n=size(train_data,1);

right=0;
all=0;

for i=1:size(new_data,1)
    cnt=zeros(c,1);
    test_mat=repmat(new_data(:,i),1,size(train_data,1));  
    dist_mat=(train_data-double(test_mat)) .^2;  
    dist_array=sum(dist_mat);  
    [~, neighbors]=sort(dist_array);
    neighbors=neighbors(1:k);
    
    for i=1:k
        ind=find(ClassLabel==train_label(neighbors(i)));
        cnt(ind)=cnt(ind)+1;
    end
    [~,ind]=max(cnt);
    
    if(ind==new_label(i))
        right=right+1;
    end
    all=all+1;
end

new_accu=right/all;

right1=0;
all1=0;

for i=1:size(new_data,1)
    train_data1=train_data;
    new_data1=train_data1(i,:);
    train_data1(i,:)=[];
    train_label1=train_label;
    new_label1=train_label1(i,:);
    train_label1(i,:)=[];
    
    cnt=zeros(c,1);
    test_mat=repmat(new_data1(:,i),1,size(train_data1,1));  
    dist_mat=(train_data1-double(test_mat)) .^2;  
    dist_array=sum(dist_mat);  
    [~, neighbors]=sort(dist_array);
    neighbors=neighbors(1:k);

    for i=1:k
        ind=find(ClassLabel==train_label1(neighbors(i)));
        cnt(ind)=cnt(ind)+1;
    end
    [~,ind]=max(cnt);
    
    if(ind==new_label1(i))
        right1=right1+1;
    end
    all1=all1+1;
end

train_accu=right1/all1;

end  